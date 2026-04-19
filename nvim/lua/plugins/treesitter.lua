local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
      'bash',
      'bicep',
      'c',
      'cpp',
      'c_sharp',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'editorconfig',
      'git_config',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'html',
      'javascript',
      'json',
      'kusto',
      'latex',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'python',
      'powershell',
      'query',
      'sql',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    },
    -- Autoinstall languages that are not installed
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
}

return M
