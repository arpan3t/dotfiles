local M = {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
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
  init_options = {
    settings = {
      args = { '--format', 'text' },
      format = { enable = true },
      lint = { enable = true },
    },
    configuration = {
      format = {
        ['quote-style'] = 'single',
      },
    },
  },
}

return M
