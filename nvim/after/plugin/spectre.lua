vim.keymap.set('n', '<leader>PP', '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>Pw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word"
})
vim.keymap.set('v', '<leader>Pw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word"
})
vim.keymap.set('n', '<leader>Pp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file"
})
