require 'core.global'
require 'core.options'
require 'core.mapping'
require 'core.lazy'
require 'core.autocmd'

require 'config.aadb2c'
require 'config.bicep'
require 'config.md'

vim.lsp.enable {
  'clangd',
  'ty',
  'ruff',
  'lemminx',
  'marksman',
  'ms-sqltools',
  'jsonls',
  'lua_ls',
  'tombi',
  'roslyn_ls',
}

-- vim.lsp.set_log_level 'debug'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
