vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>c", "<cmd>Bunlink<cr>", { desc = "Buffer unlink" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- fix J: keep the cursor
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<C-p>", [["_dP]], { desc = "replace text without overriding the register" })
vim.keymap.set({ "n", "v" }, "<C-d>", [["_d]], { desc = "delete text without overriding the register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank line to clipboard" })

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace word under cursor" })
