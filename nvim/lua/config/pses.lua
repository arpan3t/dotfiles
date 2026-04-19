-- TODO: Check if LSP is already listening on pipe.. else start LSP server for pipe
-- TODO: Handle on exit cleanup of LSP server process
--
local function get_root_dir(bufn)
  local git_dir = vim.fs.dirname(vim.fs.find('.git', { path = bufn, upward = true })[1])
  local root_dir
  if git_dir == nil then
    root_dir = vim.fs.dirname(bufn)
  else
    root_dir = git_dir
  end
  return root_dir
end

local function get_pipe_name(root_dir, feature)
  local pipe_name = string.gsub(root_dir, '/', '_')
  pipe_name = string.sub(pipe_name, 4)
  pipe_name = 'NVIM_PSES_' .. pipe_name .. '.' .. feature
  return pipe_name
end

local function sleep(n)
  if n > 0 then
    os.execute('ping -n ' .. tonumber(n + 1) .. ' localhost > NUL')
  end
end

local function start_pses(root_dir, lsp, dbg, repl)
  local command
  local temp_path = vim.fn.stdpath 'cache'
  local bundle_path = vim.fn.stdpath 'data' .. '/lsp/powershell-editor-services/'
  local base_cmd_fmt =
    [[& '%s/PowerShellEditorServices/Start-EditorServices.ps1' -BundledModulesPath '%s' -LogPath '%s/pses_log' -SessionDetailsPath '%s/pses_session.json' -FeatureFlags @() -AdditionalModules @() -HostName nvim -HostProfileId 0 -HostVersion 1.0.0  -LogLevel Normal]]
  command = base_cmd_fmt:format(bundle_path, bundle_path, temp_path, temp_path)

  if lsp == true then
    local lsp_pipe = get_pipe_name(root_dir, 'lsp')
    local lsp_cmd_fmt = [[-LanguageServicePipeName '%s']]
    local lsp_cmd = lsp_cmd_fmt:format(lsp_pipe)
    command = command .. ' ' .. lsp_cmd
  end

  if dbg == true then
    local dbg_pipe = get_pipe_name(root_dir, 'dbg')
    local dbg_cmd_fmt = [[-DebugServicePipeName '%s']]
    local dbg_cmd = dbg_cmd_fmt:format(dbg_pipe)
    command = command .. ' ' .. dbg_cmd
  end

  if repl == true then
    command = command .. ' ' .. '-EnableConsoleRepl'
  end

  local cmd = {
    'pwsh',
    '-NoLogo',
    '-NoProfile',
    '-Command',
    command,
  }

  local ok, pses_proc = pcall(vim.system, cmd)

  if not ok then
    vim.notify('Error starting PowerShell Editor Services: ' .. pses_proc, vim.log.levels.ERROR)
    return nil
  else
    return pses_proc
  end
end

local function connect_or_start_pses()
  local bufn = vim.api.nvim_buf_get_name(0)
  local root_dir = get_root_dir(bufn)
  local pipe_name = get_pipe_name(root_dir, 'lsp')
  local pipe_name_fmt = '\\\\.\\pipe\\' .. pipe_name
  local rpc_named_pipe = vim.lsp.rpc.connect(pipe_name_fmt)

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  local lspconfig = require 'lspconfig'

  capabilities = vim.tbl_deep_extend('force', capabilities, cmp_capabilities)

  local config = {
    capabilities = capabilities,
    cmd = rpc_named_pipe,
    filetypes = { 'ps1', 'psm1', 'psd1' },
    settings = {
      powershell = {
        codeFormatting = {
          preset = 'Stroustrup',
        },
      },
    },
  }

  local pses_status = start_pses(root_dir, true, false, false)
  sleep(1)
  if pses_status == nil then
    vim.notify('PSES pipe already exists, connecting to existing instance...', vim.log.levels.INFO)
  end
  local ok, _ = pcall(lspconfig.powershell_es.setup, config)
  if not ok then
    vim.notify('PowerShell Editor Services not running, starting new instance...', vim.log.levels.INFO)
  end
end

connect_or_start_pses()
