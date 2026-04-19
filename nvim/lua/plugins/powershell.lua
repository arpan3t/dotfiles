local bundle_path = vim.fn.stdpath 'data' .. '/lsp/powershell-editor-services/'
local capabilities = vim.lsp.protocol.make_client_capabilities()

---@module "powershell"
return {
  'TheLeoP/powershell.nvim',
  ---@type powershell.user_config
  opts = {
    bundle_path = bundle_path,
    capabilities = capabilities,
    settings = {
      powershell = {
        codeFormatting = {
          preset = 'Stroustrup',
        },
      },
    },
  },
}
