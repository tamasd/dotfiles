vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Edit previous file" })
vim.keymap.set("n", "<C-P>", "<C-I>")

vim.keymap.set("n", "<leader>c", "<cmd>Bunlink<cr>", { desc = "Buffer unlink" })
vim.keymap.set("n", "<leader>_", "Ilet _=<esc>", { desc = "Prefix line with let _" })
vim.keymap.set("n", "<leader>;", "A;<esc>", { desc = "put the semicolon to the end of the line" })
vim.keymap.set("n", "<leader>,", "A,<esc>", { desc = "put the comma to the end of the line" })
vim.keymap.set("n", "<leader>p", ":!playerctl play-pause<cr><cr>", { desc = "play/pause media" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- fix J: keep the cursor
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "_p", [["_dP]], { desc = "replace text without overriding the register" })
vim.keymap.set({ "n", "v" }, "_d", [["_d]], { desc = "delete text without overriding the register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank line to clipboard" })

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "replace word under cursor" })

vim.keymap.set("n", "<Tab>", "<cmd>wincmd w<cr>", { desc = "Switch windows" })

vim.keymap.set("n", "-", "<cmd>Oil<cr>")

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end, { desc = "Next diagnostic" })
