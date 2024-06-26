require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
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
		"haskell",
		"haskell_persistent",
		"html",
		"ini",
		"javascript",
		"jq",
		"json",
		"json5",
		"lua",
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
	},


	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	textsubjects = {
		enable = true,
		prev_selection = ",", -- (Optional) keymap to select the previous selection
		keymaps = {
			["<C-,>"] = "textsubjects-smart",
			["<C-k>"] = "textsubjects-container-outer",
			["<C-j>"] = "textsubjects-container-inner",
		},
	},
})

local tsht = require("tsht")

vim.keymap.set("", "<leader>ht", function()
	tsht.nodes()
end, { desc = "treehopper" })

require("treesitter-context").setup({
	max_lines = 2,
	trim_scope = "inner",
})
