local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.formatting.mix.with({
		extra_filetypes = { "heex" },
	}),
	null_ls.builtins.formatting.deno_fmt,
	null_ls.builtins.formatting.dprint.with({
		extra_filetypes = { "astro", "svelte" },
	}),
	null_ls.builtins.formatting.stylua,
}

-- Format on save
-- source: null-ls Github Wiki
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr, async = false })
				end,
			})
		end
	end,
})
