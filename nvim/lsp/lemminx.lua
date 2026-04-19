local cache_dir = vim.fn.stdpath 'data' .. '/cache/'

---@type vim.lsp.Config
return {
  cmd = { 'lemminx' },
  filetypes = { 'xml', 'xsd' },
  init_options = {
    settings = {
      xml = {
        fileAssociations = {
          {
            systemId = 'C:\\CODE\\AADB2C\\TrustFrameworkPolicy_0.3.0.0.xsd',
            pattern = '**.xml',
          },
        },
        format = {
          closingBracketNewLine = true,
          enabled = true,
          maxLineWidth = 0,
          splitAttributes = false,
        },
        server = {
          workDir = cache_dir,
        },
      },
    },
  },
}
