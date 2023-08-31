require("mason-nvim-dap").setup({
	ensure_installed = { "codelldb", "delve" },
	handlers = {},
})

local dap = require("dap")

vim.keymap.set("n", "<F6>", function()
	dap.toggle_breakpoint()
end, { desc = "toggle breakpoint" })
vim.keymap.set("n", "<F5>", function()
	dap.continue()
end, { desc = "resume execution" })
vim.keymap.set("n", "<F7>", function()
	dap.step_into()
end, { desc = "step into" })
vim.keymap.set("n", "<F8>", function()
	dap.step_over()
end, { desc = "step over" })
