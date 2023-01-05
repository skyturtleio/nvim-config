-- [[ Keymaps ]]

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
vim.g.mapleader = " "
-- keymap("", "<Space>", "<Nop>", opts)

-- [[ Modes ]]
--    normal_mode = "n",
--    insert_mode = "i",
--    visual_mode = "v",
--    visual_block_mode = "x",
--    term_mode = "t",
--    command_mode = "c",

-- [[ Keys ]]
--   ctrl - example below is ctrl + h
--      keymap("n", "<C-h>", "<C-w>h", opts)
--   shift - example below is shift + l
--      keymap("n", "<S-l>", ":bnext<CR>", opts)

-- Normal Mode --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Close window
keymap("n", "<leader>wc", ":clo<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert Mode --
-- Press jj fast to escape
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- [[Plugins ]]
-- LSP 
-- See skyturtle.lsp for keymaps related to "hover", "go to definition", etc.
keymap("n", "<leader>li", ":LspInfo<CR>", opts)
keymap("n", "<leader>lr", ":LspRestart<CR>", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts) -- "Find file"
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
