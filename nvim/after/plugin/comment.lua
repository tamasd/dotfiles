require("Comment").setup({
    mappings = false,
})

local call = require("Comment.api").call

vim.keymap.set(
    "n",
    "<C-c>",
    call("toggle.linewise", "g@"),
    { expr = true, desc = "Comment toggle linewise" }
)
vim.keymap.set(
    "n",
    "<C-C>",
    call("toggle.blockwise", "g@"),
    { expr = true, desc = "Comment toggle blockwise" }
)
vim.keymap.set(
    "x",
    "<C-c>",
    "<ESC><CMD>lua require(\"Comment.api\").locked(\"toggle.linewise\")(vim.fn.visualmode())<CR>",
    { desc = "Comment toggle linewise (visual)" }
)
vim.keymap.set(
    "x",
    "<C-C>",
    "<ESC><CMD>lua require(\"Comment.api\").locked(\"toggle.blockwise\")(vim.fn.visualmode())<CR>",
    { desc = "Comment toggle blockwise (visual)" }
)
