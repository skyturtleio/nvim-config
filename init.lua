require "user.options"
require "user.keymaps"
require "user.plugins"
-- require "user.autocommands"
require "user.colorscheme"
require "user.cmp"
require "user.telescope"
require "user.gitsigns"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"
require "user.lualine"
require "user.toggleterm"
require "user.impatient"
require "user.illuminate"
require "user.indentline"
require "skyturtle.lsp"
-- require "user.lsp"
-- require "user.dap"
--
vim.filetype.add {
  extension = {
    astro = "astro",
  },
}
