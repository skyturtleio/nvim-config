-- [[ Package Manager - Packer ]]
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use({ "wbthomason/packer.nvim", commit = "1d0cf98" })

	use({
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		commit = "5da5745",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", commit = "b68d3be" },
			{ "williamboman/mason-lspconfig.nvim", commit = "4f1c727" },

			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim", commit = "f1c375b" },

			-- Additional lua configuration, makes nvim stuff amazing
			{ "folke/neodev.nvim", commit = "a2b1d8f" },
		},
	})

	use({
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		commit = "2743dd9",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp", commit = "44b16d1" },
			{ "hrsh7th/cmp-buffer", commit = "3022dbc" },
			{ "L3MON4D3/LuaSnip", commit = "105b5f7" },
			{ "saadparwaiz1/cmp_luasnip", commit = "1809552" },
		},
	})

	use({
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		commit = "8d2eb35",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		commit = "b55fe61",
		after = "nvim-treesitter",
	})

	-- Git related plugins
	use({ "tpope/vim-fugitive", commit = "5b52a0f" })
	use({ "tpope/vim-rhubarb", commit = "cad60fe" })
	use({ "lewis6991/gitsigns.nvim", commit = "b1f9cf7" })

	use({ "nvim-lualine/lualine.nvim", commit = "e99d733" }) -- Fancier statusline
	use({ "lukas-reineke/indent-blankline.nvim", commit = "018bd04" }) -- Add indentation guides even on blank lines
	use({ "numToStr/Comment.nvim", commit = "8d3aa5c" }) -- "gc" to comment visual regions/lines
	-- use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	-- Fuzzy Finder (files, lsp, etc)
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		commit = "c5b11f4",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		commit = "9bc8237",
		run = "make",
		cond = vim.fn.executable("make") == 1,
	})

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})
