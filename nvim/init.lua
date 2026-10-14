if vim.fn.has("nvim-0.12") == 0 then
	error("This init.lua targets Neovim 0.12+.")
end

-- SECTION: COMMON SETTINGS
do
	vim.loader.enable()

	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	vim.opt.termguicolors = true
	vim.g.have_nerd_font = true
	vim.o.mouse = "a"
	vim.o.breakindent = true
	vim.o.ignorecase = true
	vim.o.smartcase = true
	vim.o.signcolumn = "yes"
	vim.o.updatetime = 250
	vim.o.timeoutlen = 300
	vim.o.splitright = true
	vim.o.splitbelow = true
	vim.o.list = true
	vim.opt.listchars = { tab = " ", trail = "·", nbsp = "␣" }
	vim.opt.hlsearch = false
	vim.opt.incsearch = true
	vim.o.inccommand = "split"
	vim.o.cursorline = true
	vim.o.scrolloff = 10
	vim.o.confirm = true
	vim.opt.nu = true
	vim.opt.relativenumber = true
	vim.opt.equalalways = true
	vim.opt.ignorecase = true
	vim.opt.tabstop = 4
	vim.opt.softtabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.expandtab = false
	vim.opt.smartindent = true
	vim.opt.wrap = false
	vim.opt.swapfile = false
	vim.opt.backup = false
	vim.opt.autoread = true
	vim.opt.shadafile = "NONE"
	vim.opt.guicursor = {
		"n-v-c:block-Cursor/lCursor",
		"i-ci:ver25-CursorInsert/lCursorInsert",
		"r-cr:hor20-CursorInsert/lCursorInsert",
		"o:block-Cursor",
	}

	local osc52 = require("vim.ui.clipboard.osc52")
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = osc52.copy("+"),
			["*"] = osc52.copy("*"),
		},
		paste = {
			["+"] = osc52.paste("+"),
			["*"] = osc52.paste("*"),
		},
	}
end

-- SECTION: PLUGINS
do
	vim.pack.add({
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/nvim-telescope/telescope.nvim",
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/mfussenegger/nvim-dap",
		"https://github.com/smoka7/hop.nvim",
		"https://github.com/nvim-mini/mini.nvim",
		"https://github.com/lewis6991/gitsigns.nvim",
		{ src = "https://github.com/saghen/blink.cmp", version = "v1" },
	})
end

-- SECTION: TREESITTER
do
	local ts = require("nvim-treesitter")

	local ft = {
		"bash",
		"c",
		"css",
		"csv",
		"dockerfile",
		"erlang",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"gpg",
		"html",
		"ini",
		"javascript",
		"jq",
		"json",
		"json5",
		"lua",
		"odin",
		"python",
		"regex",
		"rust",
		"sql",
		"toml",
		"tsv",
		"typescript",
		"vim",
		"vimdoc",
		"xml",
		"yaml",
		"zig",
	}

	ts.setup({})
	ts.install(ft)

	vim.api.nvim_create_autocmd("FileType", {
		pattern = ft,
		callback = function() vim.treesitter.start() end,
	})
	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

-- SECTION: CODE COMPLETION (BLINK)
do
	require("blink.cmp").setup({
		keymap = { preset = "super-tab" },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono"
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		signature = { enabled = true },
		completion = {
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
			},
			ghost_text = {
				enabled = true,
			},
		},
	})
end

-- SECTION: LSP
do
	local cwd = vim.fn.getcwd()

	vim.lsp.config["ols"] = {
		cmd = { "ols" },
		filetypes = { "odin" },
		root_dir = cwd,
		settings = {},
	}

	vim.lsp.config["gopls"] = {
		cmd = { "gopls", "serve" },
		filetypes = { "go", "gomod" },
		root_dir = cwd,
		settings = {
			semanticTokens = true,
			gopls = {
				analyses = {
					appends = true,
					assign = true,
					atomic = true,
					atomicalign = true,
					bools = true,
					buildtag = true,
					cgocall = true,
					composites = true,
					copylocks = true,
					deepequalerrors = true,
					defer = true,
					defers = true,
					deprecated = true,
					directive = true,
					embed = true,
					errorsas = true,
					fillreturns = true,
					fillstruct = true,
					gofix = true,
					hostport = true,
					httpresponse = true,
					ifaceassert = true,
					infertypeargs = true,
					loopclosure = true,
					lostcancel = true,
					modernize = true,
					nilfunc = true,
					nilness = true,
					nonewvars = true,
					noresultvalues = true,
					printf = true,
					shadow = true,
					shift = true,
					simplifycompositelit = true,
					simplifyrange = true,
					simplifyslice = true,
					slog = true,
					sortslice = true,
					stdmethods = true,
					stringintconv = true,
					structtag = true,
					stubmethods = true,
					testinggoroutine = true,
					tests = true,
					timeformat = true,
					undeclaredname = true,
					unmarshal = true,
					unreachable = true,
					unsafeptr = true,
					unusedfunc = true,
					unusedparams = true,
					unusedresult = true,
					unusedvariable = true,
					unusedwrite = true,
					useany = true,
				},
				usePlaceholders = false,
				completeUnimported = true,
				staticcheck = false,
				matcher = "Fuzzy",
				diagnosticsDelay = "500ms",
				symbolMatcher = "fuzzy",
				completeFunctionCalls = true,
				vulncheck = "Imports",
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true
				},
				codelenses = {
					gc_details = true,
					generate = true,
					regenerate_cgo = true,
					govulncheck = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					run_govulncheck = true,
					vendor = false,
				},
			},
		},
		-- capabilities = capabilities,
	}

	vim.lsp.config["golangci_lint_ls"] = {
		cmd = { "golangci-lint-langserver" },
		filetypes = { "go", "gomod" },
		root_dir = cwd,
		init_options = {
			command = {
				"golangci-lint",
				"run",
				"--show-stats=false",
				"--output.json.path=stdout",
				"--issues-exit-code=1",
			},
		},
	}

	vim.schedule(function()
		vim.lsp.enable(vim.tbl_map(function(config)
			return config.name
		end, vim.lsp.get_configs()))
	end)

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then return end

			vim.lsp.codelens.enable(true)
			vim.lsp.inlay_hint.enable(true)
			vim.lsp.inline_completion.enable()

			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
			end

			local t = require("telescope.builtin")
			map("n", "gd", t.lsp_definitions, "Go to definition")
			map("n", "gy", t.lsp_type_definitions, "Go to type definition")
			map("n", "gr", t.lsp_references, "Go to references")
			map("n", "gi", t.lsp_implementations, "Go to implementation")

			map("n", "<F2>", vim.lsp.buf.rename, "Rename symbol")
			map("n", "<leader>a", vim.lsp.buf.code_action, "Code action")
			map("n", "<leader>l", function() 
				vim.lsp.buf.codelens.run()
			end, "Code lens")
			map("n", "K", function()
				vim.lsp.buf.hover({
					border = "rounded",
					style = "minimal",
				})
			end, "Hover")
			map("n", "<C-s>", vim.lsp.buf.signature_help, "Signature help")
		end,
		})
end

-- SECTION: TELESCOPE
do
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")

	telescope.setup({
		defaults = {
			prompt_prefix = "	",
			selection_caret = "	",
			sorting_strategy = "ascending",
			layout_config = { prompt_position = "top" },
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
	})

	local function buffer_dir_files()
		builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
	end

	-- Custom sorter: filter by path, always include if it matches
	local sorters = require("telescope.sorters")
	local fzy = require("telescope.algos.fzy")

	-- Boundary-anchored fuzzy path matching: the first character of each term
	-- must sit at a word boundary (path start, after '/', '.', '_', '-', or a
	-- camelCase hump); the remaining characters are matched as a subsequence.
	local function path_term_match(term, path)
		term = term:lower()
		local lower_path = path:lower()
		local first = term:sub(1, 1)
		local first_is_sep = first:match("[/\\._%-]") ~= nil

		local from = 1
		while true do
			local s = lower_path:find(first, from, true)
			if not s then
				return false
			end
			local prev = path:sub(s - 1, s - 1)
			local curr = path:sub(s, s)
			local at_boundary = s == 1
			or first_is_sep
			or prev:match("[/\\._%-]") ~= nil
			or (prev:match("%l") ~= nil and curr:match("%u") ~= nil)

			if at_boundary then
				local j = s + 1
				local ok = true
				for i = 2, #term do
					j = lower_path:find(term:sub(i, i), j, true)
					if not j then
						ok = false
						break
					end
					j = j + 1
				end
				if ok then
					return true
				end
			end
			from = s + 1
		end
	end

	-- Every whitespace-separated term in the filter must match the path.
	local function path_matches(filter, path)
		if not filter or filter == "" then
			return true
		end
		for term in filter:gmatch("%S+") do
			if not path_term_match(term, path) then
				return false
			end
		end
		return true
	end

	-- Live grep with path filtering: "grep pattern  path filter"
	local function live_grep_path(opts)
		opts = opts or {}

		-- Shared state between the prompt filter and the sorter
		local path_filter = nil

		-- Split "grep_pattern  path_filter" on the first double space
		local function parse_prompt(prompt)
			if not prompt or prompt == "" then
				return prompt, nil
			end
			local sep = prompt:find("  ", 1, true)
			if not sep then
				return prompt, nil
			end
			local grep_part = prompt:sub(1, sep - 1)
			local path_part = prompt:sub(sep + 2):gsub("^%s+", "")
			return grep_part, path_part
		end

		opts.sorter = sorters.Sorter:new({
			scoring_function = function(_, _, _, entry)
				if path_filter and path_filter ~= "" then
					if not path_matches(path_filter, entry.filename or "") then
						return -1
					end
				end
				return 1
			end,
			highlighter = function(_, prompt, display)
				return fzy.positions(prompt, display)
			end,
		})

		-- Intercept the prompt: extract path filter, send only grep part to rg
		opts.on_input_filter_cb = function(prompt)
			local grep_part, path_part = parse_prompt(prompt)
			path_filter = path_part
			return { prompt = grep_part }
		end

		builtin.live_grep(opts)
	end

	-- LSP document symbols with type filter: "symbol pattern  type filter"
	local function lsp_document_symbols_typed(opts)
		opts = opts or {}

		-- Split "symbol_pattern  type_filter" on the first double space
		local function parse_prompt(prompt)
			if not prompt or prompt == "" then
				return prompt, nil
			end
			local sep = prompt:find("  ", 1, true)
			if not sep then
				return prompt, nil
			end
			local symbol_part = prompt:sub(1, sep - 1)
			local type_part = prompt:sub(sep + 2):gsub("^%s+", "")
			return symbol_part, type_part
		end

		opts.sorter = sorters.Sorter:new({
			scoring_function = function(_, prompt, _, entry)
				local symbol_part, type_part = parse_prompt(prompt)

				-- Filter by symbol type (after double space)
				if type_part and type_part ~= "" then
					if not fzy.has_match(type_part, entry.symbol_type or "") then
						return -1
					end
				end

				-- Score by symbol name (before double space)
				if symbol_part and symbol_part ~= "" then
					if not fzy.has_match(symbol_part, entry.symbol_name or "") then
						return -1
					end
					return -fzy.score(symbol_part, entry.symbol_name or "")
				end

				return 0
			end,
			highlighter = function(_, prompt, display)
				local symbol_part = parse_prompt(prompt)
				if symbol_part and symbol_part ~= "" then
					return fzy.positions(symbol_part, display)
				end
				return {}
			end,
		})

		builtin.lsp_document_symbols(opts)
	end

	-- LSP dynamic workspace symbols with path and type filters
	-- Format: "name  path  type" (double-space separated; empty path = 4 spaces)
	local function lsp_dynamic_workspace_symbols_typed(opts)
		opts = opts or {}

		local path_filter = nil
		local type_filter = nil

		-- Split on double-space, keeping empty parts, then trim each
		local function parse_prompt(prompt)
			if not prompt or prompt == "" then
				return prompt or "", nil, nil
			end
			local parts = {}
			local start = 1
			while true do
				local sep_start, sep_end = prompt:find("  ", start, true)
				if not sep_start then
					table.insert(parts, prompt:sub(start))
					break
				end
				table.insert(parts, prompt:sub(start, sep_start - 1))
				start = sep_end + 1
			end
			for i, part in ipairs(parts) do
				parts[i] = part:gsub("^%s+", ""):gsub("%s+$", "")
			end
			local name = parts[1] or ""
			local path = parts[2]
			local typ = parts[3]
			return name, path, typ
		end

		opts.on_input_filter_cb = function(prompt)
			local name, path, typ = parse_prompt(prompt)
			path_filter = path
			type_filter = typ
			return { prompt = name }
		end

		opts.sorter = sorters.Sorter:new({
			scoring_function = function(_, prompt, _, entry)
				-- Filter by path (from closure, set by on_input_filter_cb)
				if path_filter and path_filter ~= "" then
					if not path_matches(path_filter, entry.filename or "") then
						return -1
					end
				end

				-- Filter by type (from closure)
				if type_filter and type_filter ~= "" then
					if not fzy.has_match(type_filter, entry.symbol_type or "") then
						return -1
					end
				end

				-- Score by symbol name (prompt is name-only after on_input_filter_cb)
				if prompt and prompt ~= "" then
					if not fzy.has_match(prompt, entry.symbol_name or "") then
						return -1
					end
					return -fzy.score(prompt, entry.symbol_name or "")
				end

				return 0
			end,
			highlighter = function(_, prompt, display)
				if prompt and prompt ~= "" then
					return fzy.positions(prompt, display)
				end
				return {}
			end,
		})

		builtin.lsp_dynamic_workspace_symbols(opts)
	end

	vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Files" })
	vim.keymap.set("n", "<leader>F", buffer_dir_files, { desc = "Files in buffer directory" })
	vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })
	vim.keymap.set("n", "<leader>j", builtin.jumplist, { desc = "Jumplist" })
	vim.keymap.set("n", "<leader>s", lsp_document_symbols_typed, { desc = "Document symbols" })
	vim.keymap.set("n", "<leader>S", lsp_dynamic_workspace_symbols_typed, { desc = "Workspace symbols" })
	vim.keymap.set("n", "<leader>d", function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Diagnostics" })
	vim.keymap.set("n", "<leader>D", function() builtin.diagnostics({ bufnr = nil }) end, { desc = "Workspace diagnostics" })
	vim.keymap.set("n", "<leader><C-d>", function() builtin.diagnostics({ bufnr = nil, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Workspace errors" })
	vim.keymap.set("n", "<leader>/", live_grep_path, { desc = "Live grep" })
	vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Open last" })

	-- disable autocomplete in the telescope
	vim.api.nvim_create_autocmd("InsertEnter", {
		pattern = "*",
		callback = function(args)
			if vim.bo[args.buf].buftype == "prompt" then
				vim.bo[args.buf].complete = ""
				vim.bo[args.buf].completeopt = "menuone"
				vim.bo[args.buf].omnifunc = ""
			end
		end,
	})
end

-- SECTION: KEYMAP
do
	vim.keymap.set("n", "<C-p>", "<C-i>", { desc = "Jump forward" })
	vim.keymap.set("n", "<leader>_", "Ilet _=<esc>", { desc = "Prefix line with let _" })
	vim.keymap.set("n", "<leader>;", "A;<esc>", { desc = "put the semicolon to the end of the line" })
	vim.keymap.set("n", "<leader>,", "A,<esc>", { desc = "put the comma to the end of the line" })
	vim.keymap.set("n", "<leader>.", "A.<esc>", { desc = "put the dot to the end of the line" })
	vim.keymap.set("n", "<leader>p", ":!playerctl play-pause<cr><cr>", { desc = "play/pause media" })
	vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Edit previous file" })
	vim.keymap.set("v", "J", ":m \">+1<CR>gv=gv", { desc = "Move line down" })
	vim.keymap.set("v", "K", ":m \"<-2<CR>gv=gv", { desc = "Move line up" })
	vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to clipboard" })
	vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank line to clipboard" })
	vim.keymap.set("n", "<Tab>", "<cmd>wincmd w<cr>", { desc = "Switch windows" })
	vim.keymap.set("n", "<leader>q", function()
		local windows = vim.fn.getwininfo()
		for _, win in ipairs(windows) do
			if win.quickfix == 1 then
				vim.cmd("cclose")
				return
			end
		end

		vim.cmd("copen")
	end, { desc = "Toggle quickfix" })
	vim.keymap.set("n", "<C-c>", "gcc", { remap = true, desc = "Toggle comment on current line" })
	vim.keymap.set("v", "<C-c>", "gc", { remap = true, desc = "Toggle comment on selection" })

	do
		local select = require("vim.treesitter._select")

		vim.keymap.set({ "n", "x", "o" }, "<C-k>", function()
			if vim.treesitter.get_parser(nil, nil, { error = false }) then
				select.select_parent(vim.v.count1)
			else
				vim.lsp.buf.selection_range(vim.v.count1)
			end
		end, { desc = "Expand selection to parent node" })

		vim.keymap.set({ "n", "x", "o" }, "<C-j>", function()
			if vim.treesitter.get_parser(nil, nil, { error = false }) then
				select.select_child(vim.v.count1)
			else
				vim.lsp.buf.selection_range(-vim.v.count1)
			end
		end, { desc = "Shrink selection to child node" })
	end
end

-- SECTION: VERSION CONTROL
do
	require("gitsigns").setup()
end

-- SECTION: STATUSLINE
do
	local icons = {
		["asm"] = "",
		["awk"] = "",
		["bash"] = "󱆃",
		["c"] = "",
		["cmake"] = "",
		["cpp"] = "",
		["diff"] = "",
		["dockerfile"] = "",
		["erlang"] = "",
		["gitconfig"] = "",
		["gitignore"] = "",
		["glsl"] = "",
		["go"] = "",
		["gomod"] = "",
		["html"] = "",
		["javascript"] = "",
		["json"] = "",
		["json5"] = "",
		["jsonc"] = "",
		["lua"] = "",
		["make"] = "",
		["markdown"] = "",
		["odin"] = "󰟢",
		["php"] = "",
		["r"] = "",
		["sh"] = "󱆃",
		["sql"] = "",
		["tex"] = "",
		["typescript"] = "",
		["yaml"] = "",
		["zig"] = "",

		["default"] = "",
	}

	local function diag_counts()
		local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		local i = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		local h = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })

		local active = vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin)
		local nc = active and "" or "NC"

		local parts = {}
		if e > 0 then parts[#parts + 1] = "%#StatusDiagnosticError" .. nc .. "#E:" .. e .. "%*" end
		if w > 0 then parts[#parts + 1] = "%#StatusDiagnosticWarning" .. nc .. "#W:" .. w .. "%*" end
		if i > 0 then parts[#parts + 1] = "%#StatusDiagnosticInfo" .. nc .. "#I:" .. i .. "%*" end
		if h > 0 then parts[#parts + 1] = "%#StatusDiagnosticHint" .. nc .. "#H:" .. h .. "%*" end
		return table.concat(parts, " ")
	end

	local function vcs()
		local active = vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin)
		local nc = active and "" or "NC"
		local head = vim.b.gitsigns_head
		if head then
			return "%#StatusVCSHead" .. nc .. "#@ " .. head .. "%*"
		end

		return ""
	end

	_G._statusline = function()
		local file = vim.fn.expand("%:.")
		if file == "" then file = "[No Name]" end
		if vim.bo.readonly then file = file .. " [RO]" end
		if vim.bo.modified then file = file .. " [+]" end
		local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
		local pos = string.format("%d:%d", vim.fn.line("."), vim.fn.col("."))
		local total = vim.fn.line("$")
		local enc = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or "utf-8"
		local eol = vim.bo.fileformat
		local d = diag_counts()
		return string.format(
			" %s %s %s %%= %s  %s  %s/%s  %s  %s ",
			icons[ft] or icons["default"],
			file,
			vcs(),
			d,
			ft,
			pos,
			total,
			enc,
			eol
		)
	end

	vim.opt.statusline = "%{%v:lua._statusline()%}"
end

-- SECTION: DIAGNOSTICS
do
	vim.diagnostic.config({
		virtual_text = false,
		virtual_lines = false,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = { border = "single", source = "if_many" },
	})

	local function diagnostic_float()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end

	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			if #vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 }) > 0 then
				diagnostic_float()
			end
		end,
	})
end

-- SECTION: AUTOCOMMANDS
do
	local function client_supports_code_action(client, kind)
		local cap = client.server_capabilities.codeActionProvider
		if not cap then
			return false
		end
		-- `true` means "I support code actions, ask me"
		if cap == true then
			return true
		end
		-- Otherwise it may be { codeActionKinds = { ... } }
		if type(cap) == "table" and cap.codeActionKinds then
			for _, k in ipairs(cap.codeActionKinds) do
				if k == kind or k:sub(1, #kind + 1) == kind .. "." then
					return true
				end
			end
			return false
		end
		-- Table without codeActionKinds: assume supported
		return true
	end

	local function apply_code_action(bufnr, client, kind)
		local last = vim.api.nvim_buf_line_count(bufnr) - 1
		local last_text = vim.api.nvim_buf_get_lines(bufnr, last, last + 1, false)[1] or ""

		local params = {
			textDocument = { uri = vim.uri_from_bufnr(bufnr) },
			range = {
				start = { line = 0, character = 0 },
				["end"]   = { line = last, character = #last_text },
			},
			context = { only = { kind } },
		}

		local resp = client:request_sync(
			"textDocument/codeAction",
			params,
			1000,
			bufnr
		)
		if not resp or not resp.result or vim.tbl_isempty(resp.result) then
			return
		end

		local action = resp.result[1]
		local enc = client.offset_encoding or "utf-16"

		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit, enc)
		end
		if action.command then
			client:exec_cmd(action.command, { bufnr = bufnr })
		end
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function(args)
			-- Avoid formatting in insert mode (optional, but recommended)
			if vim.api.nvim_get_mode().mode:sub(1, 1) ~= "n" then
				return
			end

			-- Check that at least one LSP client with formatting support is attached
			local clients = vim.lsp.get_clients({
				bufnr = args.buf,
				method = "textDocument/formatting",
			})
			if #clients == 0 then
				return
			end

			-- Perform the format (synchronously, before the write)
			vim.lsp.buf.format({
				bufnr = args.buf,
				async = false,
			})

			-- organize the imports if available
			for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
				if client_supports_code_action(client, "source.organizeImports") then
					apply_code_action(args.buf, client, "source.organizeImports")
					break
				end
			end
		end,
	})

	vim.api.nvim_create_autocmd("InsertEnter", {
		callback = function()
			vim.opt.relativenumber = false
		end
	})

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			vim.opt.relativenumber = true
		end
	})

	vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
		pattern = "*",
		command = "wincmd =",
	})

	-- fix buffer names opened by LSP
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		callback = function(args)
			local buf = args.buf
			if vim.bo[buf].buftype ~= "" then return end

			local full = vim.api.nvim_buf_get_name(buf)
			if full == "" or full:match("^%w[%w+.-]*://") then return end -- unnamed or URI

			local relative = vim.fn.fnamemodify(full, ":.")
			-- outside the cwd, or already named relatively
			if relative == full or vim.fn.bufname(buf) == relative then return end

			vim.api.nvim_buf_call(buf, function()
				-- keepalt: don't touch the alternate file
				-- noautocmd: the real path doesn't change, so nothing should see a "rename"
				vim.cmd("keepalt noautocmd silent file " .. vim.fn.fnameescape(relative))
			end)
		end,
	})
end

-- SECTION: MINI
do
	require("mini.ai").setup()
	require("mini.align").setup()
	require("mini.pairs").setup()
	require("mini.surround").setup()
end

-- SECTION: CUSTOM PLUGINS
do
	vim.keymap.set("n", "<leader>m", function()
		require("make_task_picker").pick()
	end, { desc = "Make/Task target picker" })
end

-- SECTION: COLOR SCHEME
do
	local c = {
		base03   = "#002b36",
		base025  = "#03303b",
		base02   = "#073642",
		base0175 = "#16404b",
		base015  = "#2c4f59",
		base01   = "#586e75",
		base00   = "#657b83",
		base0    = "#839496",
		base1    = "#93a1a1",
		base2    = "#eee8d5",
		base3    = "#fdf6e3",

		yellow  = "#b58900",
		orange  = "#cb4b16",
		red	    = "#dc322f",
		magenta = "#d33682",
		violet  = "#6c71c4",
		blue    = "#268bd2",
		cyan    = "#2aa198",
		green   = "#859900",
	}

	local function set_hl(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	local function set_fg(group, color, opts)
		opts = opts or {}
		opts.fg = c[color]
		set_hl(group, opts)
	end

	local function set_bg(group, color, opts)
		opts = opts or {}
		opts.bg = c[color]
		set_hl(group, opts)
	end

	local function set_colors(group, fg, bg, opts)
		opts = opts or {}

		if fg then
			opts.fg = c[fg]
		end

		if bg then
			opts.bg = c[bg]
		end

		set_hl(group, opts)
	end

	vim.cmd("hi clear")
	vim.g.colors_name = "solarized_dark_muted"

	set_colors("Normal", "base1", "base03")
	set_colors("NormalFloat", "base0", "base02")
	set_colors("LineNr", "base00", "base03")
	set_fg("CursorLineNr", "base01", { bold = true })
	set_bg("CursorLine", "base03")
	set_fg("Delimiter", "base1")
	set_colors("FloatBorder", "base01", "base02")
	set_colors("Pmenu", "base0", "base02")
	set_colors("PmenuSel", "base02", "base00")
	set_bg("PmenuSbar", "base02")
	set_bg("PmenuThumb", "base00")
	set_fg("WinSeparator", "base01")
	set_fg("StatusLine", "base00")
	set_colors("StatusLine", "base0", "base02")
	set_colors("StatusLineNC", "base01", "base02")
	set_fg("Whitespace", "base01")
	set_fg("NonText", "base01")
	set_bg("ColorColumn", "base02")
	set_fg("IblIndent", "base02")
	set_colors("Question", "base0", "base02")
	set_colors("MoreMsg", "base0", "base02")
	set_colors("ModeMsg", "base0", "base02")
	set_colors("Cursor", "base02", "cyan")
	set_colors("lCursor", "base02", "cyan")
	set_colors("TermCursor", "base02", "cyan")
	set_colors("MatchParen", "base03", "base00")
	set_colors("Cursor", "base03", "base1")
	set_colors("Visual", "base02", "cyan")
	set_bg("Visual", "base0175")
	set_fg("DiagnosticWarn", "orange", { bold = true, underline = true })
	set_fg("DiagnosticError", "red", { bold = true, underline = true })
	set_fg("DiagnosticInfo", "blue", { bold = true, underline = true })
	set_fg("DiagnosticHint", "base01", { bold = true, underline = true })
	set_hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.orange })
	set_hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
	set_hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
	set_hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.base01 })
	set_hl("DiagnosticUnnecessary", { fg = c.base01 })
	set_hl("DiagnosticDeprecated", { strikethrough = true })
	set_fg("Comment", "base01")
	set_fg("Constant", "cyan")
	set_fg("String", "cyan")
	set_fg("Character", "cyan")
	set_fg("Number", "cyan")
	set_fg("Boolean", "cyan", { bold = true })
	set_fg("Identifier", "base1")
	set_fg("Function", "blue")
	set_fg("Statement", "green")
	set_fg("Conditional", "green")
	set_fg("Repeat", "green")
	set_fg("Label", "base1", { bold = true })
	set_fg("Operator", "green")
	set_fg("Keyword", "green")
	set_fg("Exception", "yellow", { bold = true })
	set_fg("PreProc", "magenta", { bold = true })
	set_fg("Include", "green")
	set_fg("Define", "magenta", { bold = true })
	set_fg("Macro", "violet", { bold = true })
	set_fg("Type", "base1", { bold = true })
	set_fg("Special", "orange")
	set_fg("Directory", "blue")
	set_fg("Title", "blue", { bold = true })
	set_fg("ErrorMsg", "red", { bold = true, underline = true })
	set_fg("WarningMsg", "orange", { bold = true, underline = true })
	set_fg("@attribute", "base1", { bold = true })
	set_fg("@punctuation.special", "green")
	set_fg("@keyword", "green")
	set_fg("@keyword.directive", "magenta", { bold = true })
	set_fg("@keyword", "green")
	set_fg("@keyword.conditional", "green")
	set_fg("@keyword.import", "green")
	set_fg("@keyword.repeat", "green")
	set_fg("@keyword.return", "yellow")
	set_fg("@keyword.defer", "yellow", { bold = true })
	set_fg("@keyword.exception", "yellow", { bold = true })
	set_fg("@namespace", "base1")
	set_fg("@operator", "green")
	set_fg("@special", "orange")
	set_fg("@variable", "base1")
	set_fg("@variable.builtin", "cyan", { bold = true })
	set_fg("@variable.function", "blue")
	set_fg("@type", "base1", { bold = true })
	set_fg("@type.parameter", "base2", { bold = true })
	set_fg("@type.builtin", "base1", { bold = true, italic = true, })
	set_fg("@type.enum", "cyan")
	set_fg("@constructor", "blue")
	set_fg("@function", "blue")
	set_fg("@function.macro", "violet", { bold = true })
	set_fg("@function.builtin", "blue", { bold = true })
	set_fg("@function.special", "blue", { italic = true })
	set_fg("@comment", "base01")
	set_fg("@string", "cyan")
	set_fg("@string.special", "cyan", { italic = true })
	set_fg("@constant", "cyan")
	set_fg("@constant.builtin", "cyan", { bold = true })
	set_fg("@string.escape", "red", { bold = true })
	set_fg("@label", "base1", { bold = true })
	set_fg("@module", "base1")
	set_fg("@tag", "magenta")
	set_fg("@markup.heading", "blue")
	set_fg("@markup.list", "red")
	set_fg("@markup.bold", "yellow", { bold = true })
	set_fg("@markup.italic", "magenta", { italic = true })
	set_hl("@markup.strikethrough", { strikethrough = true })
	set_fg("@markup.link.url", "yellow", { underline = true })
	set_fg("@markup.link.text", "red")
	set_fg("@markup.link", "red")
	set_fg("@markup.link.label", "red")
	set_fg("@markup.quote", "cyan")
	set_fg("@markup.raw", "green")
	set_fg("DiffAdd", "green")
	set_fg("DiffChange", "orange")
	set_fg("DiffDelete", "red")
	set_fg("@diff.plus", "green")
	set_fg("@diff.delta", "orange")
	set_fg("@diff.minus", "red")
	set_fg("LspInlayHint", "base01", { italic = true })
	set_fg("VirtualText", "base01")
	set_fg("Search", "base03", { bg = c.base00 })
	set_fg("IncSearch", "base03", { bg = c.yellow })
	set_colors("Folded", "base0", "base02")
	set_fg("FoldColumn", "base01")
	set_colors("TabLine", "base01", "base02")
	set_colors("TabLineFill", "base01", "base02")
	set_colors("TabLineSel", "base1", "base03")
	set_fg("CursorColumn", "base1")
	set_fg("@lsp.typemod.variable.readonly", "cyan", { bold = false, nocombine = true })
	set_fg("@lsp.type.enumMember", "base1")
	set_fg("StatusDiagnosticError", "red", { bold = true })
	set_fg("StatusDiagnosticWarning", "yellow", { bold = true })
	set_fg("StatusDiagnosticInfo", "green", { bold = true })
	set_fg("StatusDiagnosticHint", "blue", { bold = true })
	set_fg("StatusVCSHead", "base00")
	set_fg("GitSignsAdd", "green")
	set_fg("GitSignsChange", "yellow")
	set_fg("GitSignsDelete", "red")

	vim.g.terminal_color_0	= c.base03
	vim.g.terminal_color_1	= c.red
	vim.g.terminal_color_2	= c.green
	vim.g.terminal_color_3	= c.yellow
	vim.g.terminal_color_4	= c.blue
	vim.g.terminal_color_5	= c.magenta
	vim.g.terminal_color_6	= c.cyan
	vim.g.terminal_color_7	= c.base2

	vim.g.terminal_color_8	= c.base02
	vim.g.terminal_color_9	= c.orange
	vim.g.terminal_color_10 = c.green
	vim.g.terminal_color_11 = c.yellow
	vim.g.terminal_color_12 = c.blue
	vim.g.terminal_color_13 = c.violet
	vim.g.terminal_color_14 = c.cyan
	vim.g.terminal_color_15 = c.base3
end

-- SECTION: HOP
do
	local hop = require("hop")
	-- this must come after the color scheme to enable highlight
	hop.setup({})

	vim.keymap.set("n", "gw", function()
		hop.hint_words()
	end)
end

-- SECTION: COMMANDS
do
	-- :Rename new-name.txt      rename relative to the current file's directory
	-- :Rename! new-name.txt     overwrite the target if it exists
	-- :Rename sub/dir/new.txt   also relative to the file's dir
	-- :Rename /abs/path.txt     absolute paths and ~/... work too
	vim.api.nvim_create_user_command('Rename', function(opts)
		-- tolerate surrounding quotes, e.g. :Rename "my file.txt"
		local new_name = opts.args:gsub('^"(.*)"$', '%1')

		local old = vim.api.nvim_buf_get_name(0)
		if new_name == '' or old == '' or vim.bo.buftype ~= '' then
			vim.notify('Rename: needs a named, normal buffer and a new file name', vim.log.levels.ERROR)
			return
		end

		-- Resolve the target relative to the file's directory, NOT cwd
		local dir = vim.fn.fnamemodify(old, ':h')
		if new_name:find('^[~$]') then
			new_name = vim.fn.expand(new_name)                -- support ~/x and $VAR/x
		end
		if not (new_name:sub(1, 1) == '/' or new_name:match('^%a:[/\\]')) then
			new_name = dir .. '/' .. new_name                 -- <-- the important line
		end
		local target = vim.fn.fnamemodify(new_name, ':p')

		if target == old then
			vim.notify('Rename: new name is the same', vim.log.levels.WARN)
			return
		end
		if vim.uv.fs_stat(target) and not opts.bang then
			vim.notify('Rename: target exists (use :Rename! to overwrite):\n' .. target, vim.log.levels.ERROR)
			return
		end
		if vim.fn.bufexists(target) == 1 then
			vim.notify('Rename: a buffer already has this file open: ' .. target, vim.log.levels.ERROR)
			return
		end

		-- Persist pending changes first, so the rename never loses work
		if vim.bo.modified then
			local ok, err = pcall(vim.cmd, 'update')
			if not ok then
				vim.notify('Rename: could not save buffer: ' .. err, vim.log.levels.ERROR)
				return
			end
		end

		-- Rename on disk (preserves permissions/metadata, unlike :saveas)
		local ok, err = vim.uv.fs_rename(old, target)
		if not ok then
			vim.notify('Rename failed: ' .. (err or 'unknown error'), vim.log.levels.ERROR)
			return
		end

		-- Re-point the SAME buffer at the new path
		vim.api.nvim_buf_set_name(0, target)
		vim.cmd('silent! edit!')  -- re-read from new path; re-detects filetype/modelines

		print(('Renamed %s -> %s'):format(
			vim.fn.fnamemodify(old, ':t'), vim.fn.fnamemodify(target, ':t')))
		end, {
		nargs = 1,          -- the whole tail of the line is ONE argument, so spaces need no quoting
		bang = true,        -- :Rename! overwrites an existing target
		desc = 'Rename the current file, relative to its own directory',
		complete = function(arglead)
			if arglead:match('^[/~]') then
				return vim.fn.getcompletion(arglead, 'file')
			end
			local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')
			return vim.fn.getcompletion(dir .. '/' .. arglead, 'file')  -- complete in the file's dir
		end,
	})
end
