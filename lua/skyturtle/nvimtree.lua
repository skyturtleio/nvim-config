-- NvimTree
require("nvim-tree").setup({
	view = {
		width = 45,
	},
	renderer = {
		indent_width = 3,
	},
})
-- Togggle NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "File [E]xplorer" })
