local bundle_path = vim.fn.stdpath 'data' .. '/lsp/powershell-editor-services/'
local capabilities = vim.lsp.protocol.make_client_capabilities()

require('powershell').setup {
  bundle_path = bundle_path,
  filetypes = { 'ps1', 'psm1', 'psd1' },
  capabilities = capabilities,
  settings = {
    powershell = {
      codeFormatting = {
        preset = 'Stroustrup',
      },
    },
  },
}
