-- [[ Setting options ]]
-- See `:help vim.o`

-- Set relativenumber
vim.opt.relativenumber = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true -- enables highlight groups
-- vim.cmd([[colorscheme onedark]])
local everblush = require("everblush")
everblush.setup({ nvim_tree = { contrast = true } }) -- or use contrast = false to not apply contrast

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.o.shiftwidth = 4
vim.o.tabstop = 4
