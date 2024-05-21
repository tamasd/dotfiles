local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { desc = "jump forward" })

vim.keymap.set({ "i", "s" }, "<C-H>", function()
	ls.jump(-1)
end, { desc = "jump backward" })
