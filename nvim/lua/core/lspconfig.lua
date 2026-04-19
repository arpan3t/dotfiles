local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.emmyrc.json',
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}
