-- :GoTest — run `go test` on the current file"s package.
-- If the cursor is inside a Test function, run only that test.

-- Name of the (named) function containing the cursor, or nil if outside one.
local function enclosing_function_name()
	local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = true })
	if not ok or not node then
		return nil
	end
	while node do
		local ntype = node:type()
		if ntype == "function_declaration" or ntype == "method_declaration" then
			local name_node = node:field("name")[1]
			if name_node then
				return vim.treesitter.get_node_text(name_node, 0)
			end
			return nil
		end
		node = node:parent()
	end
	return nil
end

-- Same rule `go test` itself uses: "Test" followed by a non-lowercase char.
local function is_test_name(name)
	return name:find("^Test") ~= nil and not name:sub(5):match("^%l")
end

-- One terminal window, reused between runs.
local term = { win = -1, buf = -1, job = 0 }

-- Parse `go test` output into quickfix items. go test prints locations
-- relative to the package dir, which is the cwd we run it in.
local function qf_items_from_output(raw, pkg_dir)
	local items = {}
	local test_name = nil

	for _, line in ipairs(vim.split(raw, "\n", { plain = true })) do
		line = line:gsub("\r$", "") -- pty line-ending artifact

		-- "--- FAIL: TestFoo (0.12s)" / "    --- FAIL: TestFoo/sub"
		local fail = line:match("^%s*%-%-%-%s*FAIL:%s+(%S+)")
		if fail then
			test_name = fail
		else
			-- Test log lines: "foo_test.go:12: msg"
			-- Compile errors:  "./foo_test.go:10:2: msg"
			local file, lnum, col, msg =
			line:match("^%s*([%w%./_%-]+%.go):(%d+):(%d+):%s*(.*)")
			if not file then
				file, lnum, msg = line:match("^%s*([%w%./_%-]+%.go):(%d+):%s*(.*)")
				col = nil
			end
			-- Relative paths only: absolute ones are stdlib frames from panics.
			if file and file:sub(1, 1) ~= "/" then
				items[#items + 1] = {
					filename = vim.fs.normalize(pkg_dir .. "/" .. file),
					lnum = tonumber(lnum),
					col = col and tonumber(col) or nil,
					text = (test_name and test_name .. ": " or "") .. (msg ~= "" and msg or line),
				}
			end
		end
	end

	return items
end

local function run_in_term(cmd, cwd)
	local origin = vim.api.nvim_get_current_win()

	-- Stop the previous run"s job, if any.
	if term.job > 0 then
		pcall(vim.fn.jobstop, term.job)
		term.job = 0
	end

	-- (Re)create the bottom window if the user closed it.
	if not vim.api.nvim_win_is_valid(term.win) then
		local before = vim.api.nvim_list_wins()
		vim.cmd("botright 15split")
		for _, w in ipairs(vim.api.nvim_list_wins()) do
			if not vim.tbl_contains(before, w) then
				term.win = w
			end
		end
	end

	-- Fresh buffer for the terminal, installed before wiping the old one.
	local buf = vim.api.nvim_create_buf(false, true)
	local old = term.buf
	vim.api.nvim_win_set_buf(term.win, buf)
	term.buf = buf
	if vim.api.nvim_buf_is_valid(old) then
		pcall(vim.api.nvim_buf_delete, old, { force = true })
	end

	-- Capture output for the quickfix. The pty merges stderr into stdout,
	-- so on_stdout sees everything, including compile errors; on_stderr is
	-- registered as harmless insurance.
	local chunks = {}
	local function capture(_, data)
		chunks[#chunks + 1] = table.concat(data, "\n")
	end

	vim.cmd("cclose")

	vim.api.nvim_win_call(term.win, function()
		term.job = vim.fn.termopen(cmd, {
			cwd = cwd,
			on_stdout = capture,
			on_stderr = capture,
			on_exit = function(jid, code)
				-- Ignore exit callbacks from a run we already killed/superseded.
				if jid ~= term.job then
					return
				end
				term.job = 0
				local output = table.concat(chunks, "")

				if code == 0 then
					-- Success: close the terminal, back to where we started.
					if vim.api.nvim_win_is_valid(term.win) then
						pcall(vim.api.nvim_win_close, term.win, true)
					end
					term.win = -1
					if vim.api.nvim_buf_is_valid(term.buf) then
						pcall(vim.api.nvim_buf_delete, term.buf, { force = true })
					end
					term.buf = -1
					if vim.api.nvim_win_is_valid(origin) then
						vim.api.nvim_set_current_win(origin)
					end
					vim.fn.setqflist({}, " ", {
						title = "go test " .. table.concat(cmd, " "),
						items = {},
					})
					vim.notify("GoTest: passed")
					return
				end

				-- Failure: failures -> quickfix, terminal stays open and focused.
				local items = qf_items_from_output(output, cwd)
				if #items > 0 then
					vim.fn.setqflist({}, " ", {
						title = "go test " .. table.concat(cmd, " "),
						items = items,
					})
					vim.cmd("copen")
					-- Keep the terminal focused; delete this line to leave focus
					-- on the quickfix instead.
					if vim.api.nvim_win_is_valid(term.win) then
						vim.api.nvim_set_current_win(term.win)
					end
				else
					vim.notify("GoTest: failed (no file locations found — see terminal)",
					vim.log.levels.ERROR)
				end
			end,
		})
	end)

	if term.job <= 0 then
		return vim.notify("GoTest: failed to start `go`", vim.log.levels.ERROR)
	end

	-- Focus the terminal while the tests run.
	vim.api.nvim_set_current_win(term.win)
end



vim.api.nvim_create_user_command("GoTest", function()
	if vim.bo.filetype ~= "go" then
		vim.notify("GoTest only works in Go files", vim.log.levels.ERROR)
		return
	end
	if vim.fn.expand("%:p") == "" then
		vim.notify("GoTest: buffer has no file", vim.log.levels.ERROR)
		return
	end
	if not pcall(vim.treesitter.get_parser, 0, "go") then
		vim.notify("GoTest: Go treesitter parser not installed", vim.log.levels.ERROR)
		return
	end

	-- Save so we test what we see (remove if unwanted).
	vim.cmd("silent! update")
	if vim.bo.modified then
		vim.notify("GoTest: buffer not saved — testing last saved version", vim.log.levels.WARN)
	end

	local cmd = { "go", "test", "-count=1" }

	local fname = enclosing_function_name()
	if fname and is_test_name(fname) then
		-- Anchored so TestFoo doesn"t also match TestFooBar. Subtests still run.
		cmd[#cmd + 1] = "-run"
		cmd[#cmd + 1] = "^" .. fname .. "$"
	elseif fname then
		-- Inside a non-test function: fall back to the whole package.
		vim.notify(("In %s(), not a test function — running whole package"):format(fname))
	end

	-- cwd = file"s dir + `.` is equivalent to `go test ./path/to/file/dir`,
	-- but works no matter what Neovim"s cwd is.
	cmd[#cmd + 1] = "."

	run_in_term(cmd, vim.fn.expand("%:p:h"))
end, {
desc = "go test the current package, or only the test under the cursor",
})
