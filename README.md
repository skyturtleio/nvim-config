# A Basic Stable IDE config for Neovim

Switched to using [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

Build up the features and keymaps that I want from here.

- SnipMate-like snippets are used in `snippets` directory. Example snippet files
  can be found at
  [honza/vim-snippets](https://github.com/honza/vim-snippets/tree/master/snippets)

## Notes

- If a project is using the TypeScript LSP, do I still need to enable
  `eslint_d`?
  - ESLint and related packages can provide more than the LSP, I think?

## TODO

- [ ]

## Plugins

### nvim-tree

- Normal mode: `I` to toggle Git ignored files
- Normal mode: `H` to toggle hidden files
