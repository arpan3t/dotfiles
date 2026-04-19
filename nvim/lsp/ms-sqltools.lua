local M = {
  name = 'ms-sqltools',
  cmd = { 'microsoftsqltoolsservicelayer' },
  filetypes = { 'sql' },
  root_markers = {
    'sqlproject.json',
    'sqlproj.json',
    'sqlproj.sqproj',
    'sqlproj.sqlproj',
    '.git',
  },
}
return M
