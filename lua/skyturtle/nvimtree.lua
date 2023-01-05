-- NvimTree
require("nvim-tree").setup()
-- Togggle NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {silent = true, desc = "File [E]xplorer"})

