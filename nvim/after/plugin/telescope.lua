local telescope = require("telescope")
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
local state = require("telescope.actions.state")
local actions = require("telescope.actions")

local select_or_multi = function(prompt_bufnr)
	local picker = state.get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()

	if not vim.tbl_isempty(multi) then
		actions.close(prompt_bufnr)
		for _, j in pairs(multi) do
			if j.path ~= nil then
				vim.cmd(string.format("%s %s", "edit", j.path))
			end
		end
	else
		actions.select_default(prompt_bufnr)
	end
end

telescope.setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
		},
		sorting_strategy = "ascending",
		wrap_results = true,
		dynamic_preview_title = true,
		mappings = {
			i = {
				["<CR>"] = select_or_multi,
			},
		},
	},
	pickers = {
		diagnostics = {
			--line_width = "full", -- TODO check why this is broken
			sort_by = "severity",
		},
	},
})

telescope.load_extension("ui-select")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "find files (working dir)" })
vim.keymap.set("n", "<leader>F", function()
	builtin.find_files({ cwd = utils.buffer_dir() })
end, { desc = "find files (same dir)" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "buffers" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "grep" })
vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, { desc = "document symbols" })
vim.keymap.set("n", "<leader>S", builtin.lsp_dynamic_workspace_symbols, { desc = "workspace symbols" })
vim.keymap.set("n", "<leader>d", function()
	builtin.diagnostics({ bufnr = 0 })
end, { desc = "document diagnostics" })
vim.keymap.set("n", "<leader>D", builtin.diagnostics, { desc = "workspace diagnostics" })
vim.keymap.set("n", "<leader>j", builtin.jumplist, { desc = "jumplist" })
vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "reopen picker" })

vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "git status" })
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "git commits" })
vim.keymap.set("n", "<leader>gh", builtin.git_stash, { desc = "git stash" })

vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "references" })
vim.keymap.set("n", "gci", builtin.lsp_incoming_calls, { desc = "incoming calls" })
vim.keymap.set("n", "gco", builtin.lsp_outgoing_calls, { desc = "outgoing calls" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "implementations" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "definition" })
vim.keymap.set("n", "gD", builtin.lsp_type_definitions, { desc = "type definition" })
