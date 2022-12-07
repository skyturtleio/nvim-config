-- Used to set root_dir in LSP setup() functions
local util = require("lspconfig.util")

-- [[ LSP Configuration ]]
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Enable the following language servers
local servers = {
  'astro',
  'denols',
  'pyright',
  'rust-analyzer',
  'sumneko_lua',
  'svelte',
  'tsserver',
  'tailwindcss',
}

require("mason-lspconfig").setup({
  -- servers are passed from above
  ensure_installed = servers
})

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  -- debounce_text_changes = 150,
}

-- nvim-cmp supports additional completion capabilities (from kickstart.nvim)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("lspconfig").astro.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

require("lspconfig").denols.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
}

require("lspconfig").pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

require'lspconfig'.rust_analyzer.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

require("lspconfig").sumneko_lua.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      telemetry = { enable = false},
    },
  },
}

require("lspconfig").svelte.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

require'lspconfig'.tailwindcss.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

require("lspconfig").tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  root_dir = util.root_pattern("package.json", "tsconfig.json")
}






-- Turn on LSP status information
require('fidget').setup()
