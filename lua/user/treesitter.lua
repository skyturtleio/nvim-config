local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
  return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  -- put the languages you want in this table
  ensure_installed = {
    "bash",
    "javascript",
    "help",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "svelte",
    "tsx",
    "typescript",
    "vim",
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "css" }, -- list of language that will be disabled
  },
  indent = {
    enable = true,
    disable = { "python", "css" }
  },
  autopairs = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
