local M = {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = (function()
        if vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        require 'snippets'
      end,
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = require 'config.blink',
}

return M
