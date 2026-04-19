---@type vim.lsp.Config
return {
  cmd = { 'ty', 'server' },
  filetypes = { 'python', 'py' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
    '.env',
    '.venv',
  },
  settings = {
    ty = {
      configuration = {
        rules = {
          ['unresolved-reference'] = 'warn',
        },
      },
    },
  },
}
