-- Used to set root_dir in LSP setup() functions
local util = require("lspconfig.util")

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>li", ":LspInfo<CR>", "[L]SP [i]nfo")
	nmap("<leader>lr", ":LspRestart<CR>", "[L]SP [R]estart")

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	astro = {},
	denols = {},
	elixirls = {},
	html = {},
	pyright = {},
	rust_analyzer = {},
	lua_ls = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	svelte = {},
	tsserver = {},
}

-- Setup neovim lua configuration
require("neodev").setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name) -- generic handler
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
	-- ["html"] = function()
	-- 	require("lspconfig").html.setup({
	-- 		on_attach = on_attach,
	-- 		capabilities = capabilities,
	-- 		filetypes = { "html", "heex" },
	-- 	})
	-- end,
	["denols"] = function()
		require("lspconfig").denols.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = util.root_pattern("deno.json", "deno.jsonc"),
		})
	end,
	["tsserver"] = function()
		require("lspconfig").tsserver.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = util.root_pattern("package.json"),
			single_file_support = false,
		})
	end,
})

-- nvim-cmp setup
local lspkind = require("lspkind") -- shows source and icon in nvim-cmp menu
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/snippets" })

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
			},
		}),
	},
	sources = {
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

-- Diagnostics
-- [Show line diagnostics automatically](https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization)
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.diagnostic.config({
	virtual_text = false,
})
vim.o.updatetime = 250
vim.cmd(
	[[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor", source="always"})]]
)
