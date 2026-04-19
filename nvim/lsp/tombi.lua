---@type vim.lsp.Config
return {
  cmd = { 'tombi', 'lsp' },
  filetypes = { 'toml' },
  root_markers = { 'pyproject.toml', '.git' },
}
