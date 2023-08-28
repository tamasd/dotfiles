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
            { "williamboman/mason.nvim" },
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
    { "ojroques/nvim-osc52" },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
            window = { blend = 0 },
        }
    },
    { "svrana/neosolarized.nvim",    dependencies = { "tjdevries/colorbuddy.nvim" }, opts = {} },
    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'smoka7/hydra.nvim',
        },
        opts = {},
        cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
        keys = {
            {
                mode = { 'v', 'n' },
                '<Leader>m',
                '<cmd>MCstart<cr>',
                desc = 'Create a selection for selected text or word under the cursor',
            },
        },
    },
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
    {
        'numToStr/Comment.nvim',
        lazy = false,
    }
})
