local lsp = require("lsp-zero").preset({
	manage_nvim_cmp = {
		set_sources = "recommended",
	},
})

lsp.nvim_lua_ls()

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I"
	}
})

local lspconfig = require("lspconfig")

local root = function()
	return vim.fn.getcwd()
end

lspconfig.rust_analyzer.setup({
	root_dir = root,
	settings = {
		["rust-analyzer"] = {
			assist = {
				emitMustUse = true,
			},
			cargo = {
				features = "all",
			},
			check = {
				features = "all",
			},
			diagnostics = {
				styleLints = { enable = true },
			},
			lens = {
				enable = true,
				implementations = { enable = true },
				references = {
					adt = { enable = true },
					enumVariant = { enable = true },
					trait = { enable = true },
				},
				run = { enable = true },
			},
			inlayHints = {
				bindingModeHints = { enable = true },
				closureCaptureHints = { enable = true },
				closureReturnTypeHints = { enable = true },
				discriminantHints = { enable = true },
				expressionAdjustmentHints = { enable = true },
				lifetimeElisionHints = { enable = true },
				implicitDrops = { enable = true },
				rangeExclusiveHints = { enable = true },
			},
		},
	},
})

lspconfig.gopls.setup({
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = root,
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
				fieldalignment = true,
				fillreturns = true,
				fillstruct = true,
				httpresponse = true,
				ifaceassert = true,
				infertypeargs = true,
				loopclosure = true,
				lostcancel = true,
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
				unusedparams = true,
				unusedresult = true,
				unusedvariable = true,
				unusedwrite = true,
				useany = true,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
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
			annotations = {
				bounds = true,
				escape = true,
				inline = true,
				["nil"] = true,
			},
		},
	},
})

lspconfig.golangci_lint_ls.setup({
	root_dir = root,
})

lspconfig.lua_ls.setup({
	root_dir = root,
	settings = {
		Lua = {
			hint = {
				arrayIndex = "Enable",
				enable = true,
				setType = true,
			},
			diagnostics = {
				globals = { "vim" },
			}
		}
	}
})

lspconfig.sqlls.setup({
	root_dir = root,
})

lspconfig.erlangls.setup({
	root_dir = root,
})

lspconfig.hls.setup({
	root_dir = root,
	filetypes = { "haskell", "lhaskell", "cabal" },
})

lspconfig.clangd.setup({
	root_dir = root,
})

lspconfig.pyright.setup({
	root_dir = root,
})

lspconfig.zls.setup({
	root_dir = root,
	settings = {
		enable_argument_placeholders = true,
	},
})

lspconfig.ols.setup({
	root_dir = root,
	settings = {
		enable_format = true,
		enable_hover = true,
		enable_snippets = true,
		enable_semantic_tokens = true,
		enable_document_symbols = true,
		enable_inlay_hints = true,
		enable_procedure_snippet = true,
		enable_references = true,
		enable_rename = true,
	}
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
		if vim.bo.filetype == "go" then
			vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
		end
	end
})

lsp.on_attach(function(_, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({
		buffer = bufnr,
		exclude = { "<F3>", "<F4>" },
	})
end)

lsp.setup()

local cmp = require("cmp")
local lspkind = require("lspkind")
local devicons = require("nvim-web-devicons")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.confirm({ select = false }),
		["<C-Space>"] = cmp.mapping.complete(),
	},
	formatting = {
		format = function(entry, vim_item)
			if vim.tbl_contains({ "path" }, entry.source.name) then
				local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
				if icon then
					vim_item.kind = icon
					vim_item.kind_hl_group = hl_group
					return vim_item
				end
			end
			return lspkind.cmp_format({ with_text = false })(entry, vim_item)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	enabled = function()
		-- disable in prompts and telescope
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		if buftype == "prompt" then
			return false
		end
		if vim.bo.filetype == "TelescopePrompt" then
			return false
		end

		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment")
				and not context.in_syntax_group("Comment")
		end
	end,
	preselect = cmp.PreselectMode.Item,
	view = {
		docs = { auto_open = true },
	},
	experimental = {
		ghost_text = true,
	},
})

require("lsp_signature").setup({
	hint_enable = false,
	handler_opts = {
		border = "single",
	},
})

vim.diagnostic.config({
	virtual_text = true
})

vim.lsp.inlay_hint.enable(true)

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "lsp hover" })
vim.keymap.set("n", "<leader>a", function()
	vim.lsp.buf.code_action()
end, { desc = "code actions" })

vim.keymap.set("n", "<leader>ls", function()
	vim.lsp.codelens.refresh()
end, { desc = "show codelens" })
vim.keymap.set("n", "<leader>lr", function()
	vim.lsp.codelens.run()
end, { desc = "run codelens" })
vim.keymap.set("n", "<leader>lc", function()
	vim.lsp.codelens.clear()
end, { desc = "hide codelens" })

vim.keymap.set("n", "<F3>", function()
	if vim.go.filetype == "go" then
		require("go.alternate").switch(true, "")
	end
end, { desc = "switch between alternative files" })

vim.keymap.set("n", "<F4>", function()
	if vim.go.filetype == "go" then
		require("go.gotest").test_func()
	end
end, { desc = "test function" })
