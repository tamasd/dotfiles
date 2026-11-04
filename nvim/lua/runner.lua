-- runner.lua - "run the current file"
-- Priority:
--   1. the file has the executable bit -> run it in a split terminal
--   2. a Makefile is in the cwd         -> :make run, or plain :make
--                                         when there is no `run` target
--   3. M.commands below                 -> suffix-matched command, run
--                                         in a split terminal
-- Works on Neovim 0.8+.

local M = {}

-- Custom commands. The key is matched against the END of the file name,
-- so ".py" matches foobar.py but not foobar.py.bck; when several keys
-- match, the longest one wins.
--   "%"          is replaced with the shell-escaped file path
--   no "%"       the path is appended to the command
--   function(p)  computes the command from the file path (return nil to
--                do nothing); must do its own escaping if needed
M.commands = {
	[".py"]  = "python3 %",
	[".lua"] = "lua %",
	[".rb"]  = "ruby %",
	[".pl"]  = "perl %",
	[".go"]  = "go run %",
	[".sh"]  = "sh %",
}

M.vertical    = false -- true -> terminal opens in a vertical split (:vnew)
M.height      = 15    -- rows of the horizontal terminal split
M.startinsert = false -- enter terminal-mode right after launching

-- ---------------------------------------------------------------------

local uv = vim.uv or vim.loop
local term_buf = nil -- terminal of the previous F5, replaced on re-run

local function suffix_cmd(name)
	local best, best_len = nil, -1
	for suffix, cmd in pairs(M.commands) do
		local len = #suffix
		if len > best_len and name:sub(-len) == suffix then
			best, best_len = cmd, len -- longest suffix wins
		end
	end
	return best
end

local function first_makefile()
	for _, name in ipairs { "GNUmakefile", "Makefile", "makefile" } do
		if vim.fn.filereadable(name) == 1 then
			return name
		end
	end
	return nil
end

local function makefile_has(mf, target)
	for line in io.lines(mf) do
		if line:match("^" .. target .. "%s*:") then
			return true
		end
	end
	return false
end

local function open_terminal(argv)
	-- Replace the previous run instead of piling up terminal splits.
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.api.nvim_buf_delete(term_buf, { force = true })
	end
	vim.cmd(M.vertical and "vnew" or "new")
	if not M.vertical and M.height then
		vim.cmd("resize " .. M.height)
	end
	term_buf = vim.api.nvim_get_current_buf()
	local opts = { cwd = vim.fn.getcwd() }
	if vim.fn.has("nvim-0.11") == 1 then
		opts.term = true
		vim.fn.jobstart(argv, opts)
	else
		vim.fn.termopen(argv, opts)
	end
	if M.startinsert then
		vim.cmd.startinsert()
	end
end

function M.run()
	local path = vim.api.nvim_buf_get_name(0)
	if vim.bo.buftype ~= "" or path == "" then
		vim.notify("runner: not a file buffer", vim.log.levels.WARN)
		return
	end
	if not pcall(vim.cmd, "silent update") then -- save before running
		vim.notify("runner: buffer could not be saved", vim.log.levels.ERROR)
		return
	end

	-- 1) executable bit
	if uv.fs_access(path, "X") then
		open_terminal({ path })
		return
	end

	-- 2) Makefile in the working directory
	local mf = first_makefile()
	if mf then
		vim.cmd(makefile_has(mf, "run") and "make run" or "make")
		return
	end

	-- 3) custom per-suffix commands
	local name = vim.fn.fnamemodify(path, ":t")
	local cmd = suffix_cmd(name)
	if type(cmd) == "function" then
		cmd = cmd(path)
	end
	if cmd then
		local file = vim.fn.shellescape(path)
		if cmd:find("%", 1, true) then
			cmd = cmd:gsub("%%", function() return file end)
		else
			cmd = cmd .. " " .. file
		end
		open_terminal({ vim.o.shell, vim.o.shellcmdflag, cmd })
		return
	end

	vim.notify("runner: nothing to run for " .. name, vim.log.levels.WARN)
end

return M
