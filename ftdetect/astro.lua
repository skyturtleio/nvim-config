-- For troubleshooting, see `tree-sitter-astro` repo for steps.
-- [Troubleshooting](https://github.com/virchau13/tree-sitter-astro/#troubleshooting)
-- Installing the `css` and `tsx` parsers fixed the issue of interpolated values
-- not being picked up inside Astro files
vim.filetype.add({
	extension = {
		astro = "astro",
	},
})
