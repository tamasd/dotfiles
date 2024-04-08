local dap = require("dap")
local ext = require("dap.ext.vscode")
local dapgo = require("dap-go")

dapgo.setup()

-- remove configurations
dap.configurations.go = {}

require("mason-nvim-dap").setup({
	ensure_installed = { "codelldb", "delve" },
	handlers = {},
})

-- this is needed so both default profiles and launch.json work
dap.adapters.go = dap.adapters.delve

vim.keymap.set("n", "<F6>", function()
	dap.toggle_breakpoint()
end, { desc = "toggle breakpoint" })

vim.keymap.set("n", "<F5>", function()
	if vim.fn.filereadable("launch.json") then
		ext.load_launchjs("launch.json")
	end
	dap.continue()
end, { desc = "resume execution" })

-- F17 => S-F5
vim.keymap.set("n", "<F17>", function()
	if vim.bo.filetype == "go" then
		dapgo.debug_test()
	end
end)

vim.keymap.set("n", "<F7>", function()
	dap.step_into()
end, { desc = "step into" })

vim.keymap.set("n", "<F8>", function()
	dap.step_over()
end, { desc = "step over" })

vim.keymap.set("n", "<F9>", function()
	dap.restart()
end, { desc = "restart debug session" })

vim.keymap.set("n", "<F10>", function()
	dap.terminate()
end, { desc = "terminate debug session" })

-- F22 => S-F10
vim.keymap.set("n", "<F22>", function()
	dap.disconnect()
end, { desc = "disconnect debug session" })

require("nvim-dap-virtual-text").setup {
	commented = true,
}

local dapui = require("dapui")

dapui.setup()

vim.keymap.set("n", "<F1>", function()
	dapui.toggle()
end)

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.fn.sign_define("DapLogPoint",
	{ text = "", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapBreakpoint",
	{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
)
vim.fn.sign_define("DapBreakpointConditional",
	{ text = "", texthl = "DapBreakpointConditional", linehl = "", numhl = "DapBreakpointConditional" }
)
vim.fn.sign_define("DapBreakpointRejected",
	{ text = "", texthl = "DapBreakpointRejected", linehl = "", numhl = "DapBreakpointConditional" }
)
vim.fn.sign_define("DapStopped",
	{ text = "", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStopped" }
)
