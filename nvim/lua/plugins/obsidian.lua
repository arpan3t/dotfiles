local M = {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'Obsidian Vault',
        path = '~/Documents/Obsidian Vault',
      },
    },
  },
}

return M
