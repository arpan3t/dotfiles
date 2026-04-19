local M = {
  'github/copilot.vim',
  config = function()
    vim.g.copilot_filetypes = {
      psm1 = false,
      ps1 = false,
    }
  end,
}

return M
