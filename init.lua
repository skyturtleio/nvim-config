-- disable netrw at the very start of your init.lua (strongly advised, from nvim-tree docs)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("skyturtle.packer")
require("skyturtle.options")
require("skyturtle.keymaps")
require("skyturtle.autopairs")
require("skyturtle.lualine")
require("Comment").setup()
require("skyturtle.gitsigns")
require("skyturtle.telescope")
require("skyturtle.treesitter")
require("skyturtle.lsp")
require("fidget").setup() -- Turn on lsp status information
require("skyturtle/nvimtree")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
