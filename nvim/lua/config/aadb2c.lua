vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('aadb2c', { clear = true }),
  pattern = '*.xml',
  callback = function()
    vim.keymap.set('n', '<leader>up', function()
      local ok, fidget = pcall(require, 'fidget')
      local file_path = vim.fn.expand '%:p'

      local cmd = {
        'pwsh',
        '-File',
        'C:\\CODE\\AADB2C\\utilities\\Publish-IEFPolicy.ps1',
        '-Path ',
        file_path,
      }

      local function strip_ansi(s)
        return (s:gsub('\27%[[0-9;]*[ -/]*[@-~]', ''))
      end

      vim.fn.jobstart(cmd, {
        stout_buffered = true,
        -- Callback when stdout receives data
        on_stdout = function(_, data, _)
          if data then
            for _, line in ipairs(data) do
              line = line:gsub('\r', '')
              if line ~= '' then
                line = strip_ansi(line)
                if not ok then
                  print(line)
                else
                  fidget.notify(line, 'info')
                end
              end
            end
          end
        end,

        -- Callback when stderr receives data
        on_stderr = function(_, data, _)
          if data then
            for _, line in ipairs(data) do
              line = line:gsub('\r', '')
              if line ~= '' then
                line = strip_ansi(line)
                if not ok then
                  print('ERROR: ' .. line)
                else
                  fidget.notify(line, 'error')
                end
              end
            end
          end
        end,

        -- Callback when job exits
        on_exit = function(_, exit_code, _)
          if exit_code ~= 0 then
            print('PowerShell script exited with code: ' .. exit_code)
          elseif exit_code == 0 then
            print 'Policy uploaded successfully'
            print ' '
          end
        end,
      })
    end, { desc = '[U]pload Custom [P]olicy' })
  end,
})
