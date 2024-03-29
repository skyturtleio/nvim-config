-- disable netrw at the very start of your init.lua (strongly advised, from nvim-tree docs)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("skyturtle.packer")
-- Everblush setup
local everblush = require("everblush")
everblush.setup({
	nvim_tree = { contrast = true }, -- or use contrast = false to not apply contrast
	override = {
		LineNr = { fg = "#ACB1B0" },
	},
})
require("skyturtle.options")
require("skyturtle.keymaps")
require("skyturtle.autopairs")
require("skyturtle.lualine")
require("skyturtle.indentline")
require("Comment").setup()
require("onedark").setup()
require("skyturtle.gitsigns")
require("skyturtle.telescope")
require("skyturtle.treesitter")
require("skyturtle.lsp")
require("fidget").setup() -- Turn on lsp status information
require("skyturtle/nvimtree")
require("skyturtle/null-ls")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
