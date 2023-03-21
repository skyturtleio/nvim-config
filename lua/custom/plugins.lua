-- User "custom" plugins
-- Pluins listed here are called at the end of the `packer.lua`
-- See packer.lua for the plugins that are included for the standard `kickstart.nvim`
return function(use)
	use({
		"nvim-tree/nvim-tree.lua",
		commit = "1d79a64",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		commit = "13dd1fc",
	})
	use({
		"Everblush/everblush.nvim",
		as = "everblush",
	})
	use({
		"bluz71/vim-moonfly-colors",
		branch = "cterm-compat",
	})
	use({
		"rafamadriz/friendly-snippets",
	})
	use({
		"tpope/vim-surround",
	})
	use({
		"edgedb/edgedb-vim",
	})
	use({
		"onsails/lspkind.nvim",
	})
end
