local opt = vim.opt

-- PowerShell setup for Windows
if vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  opt.shell = 'pwsh'
  opt.shellcmdflag =
    '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;'
  opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
  opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  opt.shellquote = ''
  opt.shellxquote = ''
end
-- Line number options
opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true
-- GUI options
opt.breakindent = true
opt.cursorline = true
opt.inccommand = 'split'
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.mouse = 'a'
opt.scrolloff = 10
opt.showmode = false
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.updatetime = 250

-- Search options
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Enable persistent undo
opt.undofile = true

-- Enable clipboard
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

vim.diagnostic.config {
  underline = true,
  signs = true,
  virtual_text = false,
  float = {
    show_header = true,
    source = 'if_many',
    border = 'rounded',
    focusable = false,
  },
  update_in_insert = false, -- default to false
  severity_sort = false, -- default to false
}
