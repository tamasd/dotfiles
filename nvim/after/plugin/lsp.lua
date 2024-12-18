local lsp = require("lsp-zero").preset({})

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
local cmp = require("blink.cmp")
local capabilities = cmp.get_lsp_capabilities()

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
	capabilities = capabilities,
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
	capabilities = capabilities,
})

lspconfig.golangci_lint_ls.setup({
	root_dir = root,
	capabilities = capabilities,
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
			},
		},
	},
	capabilities = capabilities,
})

lspconfig.sqlls.setup({
	root_dir = root,
	capabilities = capabilities,
})

lspconfig.erlangls.setup({
	root_dir = root,
	capabilities = capabilities,
})

lspconfig.hls.setup({
	root_dir = root,
	filetypes = { "haskell", "lhaskell", "cabal" },
	capabilities = capabilities,
})

lspconfig.clangd.setup({
	root_dir = root,
	capabilities = capabilities,
})

lspconfig.pyright.setup({
	root_dir = root,
	capabilities = capabilities,
})

lspconfig.zls.setup({
	root_dir = root,
	settings = {
		enable_argument_placeholders = true,
		enable_build_on_save = true,
		build_on_save_step = "check",
	},
	capabilities = capabilities,
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
	},
	capabilities = capabilities,
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
