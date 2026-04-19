local M = {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
    '.env',
  },
  settings = {
    pylsp = {
      plugins = {
        rope_autoimport = { enabled = false },
        pycodestyle = { enabled = false },
        flake8 = { enabled = false },
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
        yapf = { enabled = false },
        pylsp_black = { enabled = false },
        pylsp_isort = { enabled = false },
        pylsp_mypy = { enabled = false },
        autopep8 = { enabled = false },
      },
    },
  },
}

return M
