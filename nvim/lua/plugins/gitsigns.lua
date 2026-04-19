local M = {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_', show_count = true },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signs_staged = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[s]tage git hunk' })

        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[r]eset git hunk' })

        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[s]tage git hunk' })

        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[r]eset git hunk' })

        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })

        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })

        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })

        map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline' })

        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, { desc = 'git [b]lame line' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })

        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })

        map('n', '<leader>hQ', function()
          gitsigns.setqflist 'all'
        end, { desc = 'git set [Q]uick fix list all' })

        map('n', '<leader>hq', gitsigns.setqflist, { desc = 'git set [q]uick fix list' })

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })

        map('n', '<leader>td', gitsigns.toggle_deleted, { desc = '[t]oggle git show [d]eleted' })

        map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[t]oggle git show [w]ord diff' })

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'git select [h]unk' })
      end,
    }
  end,
}

return M
