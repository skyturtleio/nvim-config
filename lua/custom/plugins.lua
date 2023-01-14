-- User "custom" plugins
-- Pluins listed here are called at the end of the `packer.lua`
-- See packer.lua for the plugins that are included for the standard `kickstart.nvim`
return function(use)
	use({
		"nvim-tree/nvim-tree.lua",
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
	})
	use({
		"Everblush/everblush.nvim",
		as = "everblush",
	})
	use({
		"bluz71/vim-moonfly-colors",
		branch = "cterm-compat",
	})
end
