---@type vim.lsp.Config
return {
  cmd = {  "roslyn-language-server", "--logLevel", "Information", "--extensionLogDirectory", "/tmp/roslyn_ls/logs", "--stdio"  },
  filetypes = { 'cs' },
  root_markers = { '.csproj', '.git', '.sln' },
}
