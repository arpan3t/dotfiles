local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

dashboard.section.header.val = {
  ' █████╗ ██████╗ ██████╗  █████╗ ███╗   ██╗██████╗ ████████╗',
  '██╔══██╗██╔══██╗██╔══██╗██╔══██╗████╗  ██║╚════██╗╚══██╔══╝',
  '███████║██████╔╝██████╔╝███████║██╔██╗ ██║ █████╔╝   ██║   ',
  '██╔══██║██╔══██╗██╔═══╝ ██╔══██║██║╚██╗██║ ╚═══██╗   ██║   ',
  '██║  ██║██║  ██║██║     ██║  ██║██║ ╚████║██████╔╝   ██║   ',
  '╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝    ╚═╝   ',
}

vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#00dbc5' })
dashboard.section.header.opts.hl = 'AlphaHeader'

dashboard.section.buttons.val = {
  dashboard.button('f', '  Find File                 ', ':Telescope find_files<CR>'),
  dashboard.button('r', '  Recents                   ', ':Telescope oldfiles<CR>'),
  dashboard.button('n', '  New Document                 ', 'enew'),
  dashboard.button('q', '  Quit                      ', ':qa<CR>'),
}
vim.api.nvim_set_hl(0, 'AlphaButton', {
  fg = '#dbbe00',
  bold = true,
})

for _, btn in ipairs(dashboard.section.buttons.val) do
  btn.opts.hl = 'AlphaButton'
end

local function footer()
  return {
    [[ "Computers are useless. They can only give you answers." ]],
    [[                                        - Pablo Picasso   ]],
  }
end

dashboard.section.footer.val = footer()

vim.api.nvim_set_hl(0, 'AlphaFooter', {
  fg = '#eb4034',
  bold = true,
})

dashboard.section.footer.opts.hl = 'AlphaFooter'

alpha.setup(dashboard.opts)

vim.cmd [[
autocmd FileType alpha setlocal signcolumn=no
]]
