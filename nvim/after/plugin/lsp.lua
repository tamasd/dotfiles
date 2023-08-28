local lsp = require("lsp-zero").preset({
    manage_nvim_cmp = {
        set_sources = "recommended",
    },
})

lsp.nvim_workspace()

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
local util = require("lspconfig/util")

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
            inlayHints = {
                bindingModeHints = { enable = false },
                closureCaptureHints = { enable = false },
                closureReturnTypeHints = { enable = true },
                discriminantHints = { enable = true },
                expressionAdjustmentHints = { enable = false },
                lifetimeElisionHints = { enable = false },
            },
        },
    },
})

lspconfig.gopls.setup({
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    root_dir = root,
    settings = {
        gopls = {
            analyses = {
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
            staticcheck = true,
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
                vendor = false,
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

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end
})
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end
})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local lspkind = require("lspkind")
local devicons = require("nvim-web-devicons")

cmp.setup({
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<TAB>"] = cmp_action.tab_complete(),
        ["<S-TAB>"] = cmp_action.select_prev_or_fallback(),
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
    enabled = function()
        -- disable completion in comments
        local context = require "cmp.config.context"
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end,
    view = {
        docs = { auto_open = true },
    },
    experimental = {
        ghost_text = true,
    },
})

vim.diagnostic.config({
    virtual_text = true
})

vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, { desc = "lsp hover" })
vim.keymap.set("n", "<leader>a", function()
    vim.lsp.buf.code_action()
end, { desc = "code actions" })
