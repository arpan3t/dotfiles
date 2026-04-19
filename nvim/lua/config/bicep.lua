local M = {
  vim.filetype.add {
    extension = {
      bicep = 'bicep',
    },
  },
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'bicep',
    callback = function(ev)
      local bicep_lsp_bin = vim.fn.stdpath 'data' .. '/mason/packages/bicep-lsp/extension/bicepLanguageServer/Bicep.LangServer.dll'
      vim.lsp.start {
        name = 'bicep-lsp',
        cmd = { 'dotnet', bicep_lsp_bin },
        root_dir = vim.fs.root(ev.buf, { '.editorconfig', '.git' }),
      }
    end,
  }),
}

return M
