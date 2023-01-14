-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = " ",
		section_separators = " ",
	},
	sections = {
		lualine_b = { { "filename", path = 1 } },
		lualine_c = { "diff", "location" },
		lualine_x = { "diagnostics" },
		lualine_y = { "branch" },
		lualine_z = { "filetype" },
	},
})
