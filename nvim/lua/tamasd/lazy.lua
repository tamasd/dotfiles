local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, branch = "0.1.x" },
	{ "folke/trouble.nvim" },
	{ "windwp/nvim-autopairs",         event = "InsertEnter" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end
	},
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "lewis6991/gitsigns.nvim" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim",          opts = {} },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- Other
			{ "onsails/lspkind.nvim" },
		}
	},
	{ "lvimuser/lsp-inlayhints.nvim" },
	{ "ray-x/lsp_signature.nvim",    event = "VeryLazy" },
	{ "ojroques/nvim-osc52" },
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			window = { blend = 0 },
		}
	},
	{ "svrana/neosolarized.nvim",    dependencies = { "tjdevries/colorbuddy.nvim" } },
	{ "nvim-tree/nvim-web-devicons", opts = { color_icons = true, default = true } },
	{ "nvim-pack/nvim-spectre",      dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	{ "phaazon/hop.nvim" },
	{ "RRethy/nvim-treesitter-textsubjects" },
	{ "mfussenegger/nvim-treehopper" },
	{ "orlp/vim-bunlink" },
	{ "nvim-lualine/lualine.nvim" },
	{ "mfussenegger/nvim-dap" },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "rcarriga/nvim-dap-ui",               dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	{
		'numToStr/Comment.nvim',
		lazy = false,
	},
	{ "leoluz/nvim-dap-go" },
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup({
				lsp_cfg = false,
				lsp_inlay_hints = {
					enable = false,
				},
				diagnostic = false,
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
	},
})
