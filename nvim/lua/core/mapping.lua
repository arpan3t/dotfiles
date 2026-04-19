-- Visual highlight and move
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Join lines without moving the cursor
vim.keymap.set('n', 'J', 'mzJ`z')

-- Paste without losing the current clipboard
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Center buffer when page jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Center search results when jumping to them
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Indent paragraph without moving the cursor
vim.keymap.set('n', '=ap', "ma=ap'a")

-- Moves cursor to end of yanked text
vim.keymap.set('v', 'y', 'ygv<Esc>')

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('i', 'jk', '<Escape>')

vim.keymap.set('n', '<leader>fe', '<cmd>NERDTreeToggle<CR>', { desc = 'Toggle [F]ile [E]xplorer' })

vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'Open a [T]ab [N]ew' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
end, { desc = 'Open an new [S]plit [T]erminal' })
