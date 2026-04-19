require('render-markdown').setup {
  render_modes = true,
  completions = {
    blink = {
      enabled = true,
    },
    lsp = {
      enabled = true,
    },
  },
  code = {
    border = 'thin',
    left_pad = 2,
    language_pad = 2,
  },
  heading = {
    border = true,
    border_virtual = true,
    left_pad = 2,
    right_pad = 4,
    width = 'block',
  },
  pipe_table = {
    cell = 'trimmed',
    preset = 'round',
  },
}
---@module 'obsidian'
---@type obsidian.config.ClientOpts
require('obsidian').setup {
  legacy_commands = false,
  workspaces = {
    {
      name = 'Obsidian Vault',
      path = '~/Documents/Obsidian Vault',
    },
  },
  completion = {
    nvim_cmp = false,
    blink = false,
  },
  ui = {
    enable = false,
  },
}
