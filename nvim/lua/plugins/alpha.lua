-- Description : a lua powered greeter like vim-startify / dashboard-nvim
-- Link : https://github.com/goolord/alpha-nvim

local M = {
  'goolord/alpha-nvim',
  config = function()
    require 'config.settings.alpha'
  end,
}

return M
