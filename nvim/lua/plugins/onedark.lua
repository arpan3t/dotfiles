-- NOTE: Completion Menu Colors
local blink_hl = {
  ['BlinkCmpMenu'] = { fg = '#bbc2cf', bg = '#1e222a' },
  ['BlinkCmpMenuSelection'] = { fg = '#282c34', bg = '#51afef' },
  ['BlinkCmpMenuBorder'] = { fg = '#61afef' },
  ['BlinkCmpDoc'] = { fg = '#bbc2cf', bg = '#1e222a' },
  ['BlinkCmpDocBorder'] = { fg = '#61afef' },
  ['BlinkCmpScrollBarThumb'] = { fg = '#61afef', bg = '$blue' },
  ['BlinkCmpScrollBarGutter'] = { fg = '#61afef', bg = '$blue' },
}
--NOTE: Floating Window Colors
local float_hl = {
  ['FloatBorder'] = { fg = '#61afef', bg = '#1f2329' },
  ['NormalFloat'] = { fg = '#bbc2cf', bg = '#1f2329' },
}
-- NOTE: Markdown Colors
local markdown_hl = {
  ['RenderMarkdownH1'] = { fg = '$yellow' },
  ['RenderMarkdownH1Bg'] = { fg = '$yellow', bg = '#272e23', fmt = 'bold,italic' },
  ['RenderMarkdownH2'] = { fg = '$blue' },
  ['RenderMarkdownH2Bg'] = { fg = '$blue', bg = '#172a3a', fmt = 'bold,italic' },
  ['RenderMarkdownH3'] = { fg = '$red' },
  ['RenderMarkdownH3Bg'] = { fg = '$red', bg = '#2d2223', fmt = 'bold,italic' },
  ['RenderMarkdownH4'] = { fg = '$green' },
  ['RenderMarkdownH4Bg'] = { fg = '$green', bg = '#283A17', fmt = 'bold,italic' },
  ['RenderMarkdownH5'] = { fg = '$purple' },
  ['RenderMarkdownH5Bg'] = { fg = '$purple', bg = '#292534', fmt = 'bold,italic' },
  ['RenderMarkdownTableRow'] = { fg = '$orange', fmt = 'bold' },
  ['RenderMarkdownTableFill'] = { fg = '#a0a8b7', bg = '#1f2329' },
}
-- NOTE: Language Colors
local pwsh_hl = {
  ['@variable'] = { fg = '$cyan' },
  ['@lsp.type.variable'] = { fg = '$cyan' },
  ['@lsp.type.parameter.ps1'] = { fg = '#afafaf' },
  ['@variable.parameter.builtin.powershell'] = { fg = '#afafaf' },
  ['@comment.powershell'] = { fg = '#afafaf' },
  ['@lsp.type.comment.ps1'] = { fg = '#afafaf' },
  ['@string.powershell'] = { fg = '$green' },
  ['@lsp.type.string.ps1'] = { fg = '$green' },
  ['@variable.member.powershell'] = { fg = '$yellow' },
  ['@lsp.type.property.ps1'] = { fg = '$yellow' },
  ['@keyword.conditional.powershell'] = { fg = '$purple' },
  ['@lsp.type.keyword.ps1'] = { fg = '$purple' },
  ['@keyword.function.powershell'] = { fg = '$purple' },
  ['@keyword.powershell'] = { fg = '$purple' },
  ['@punctuation.bracket.powershell'] = { fg = '#afd7ff', fmt = 'bold' },
}
local xml_hl = {
  ['xmlComment'] = { fg = '#afafaf', fmt = 'bold' },
  ['xmlCommentPart'] = { fg = '#afafaf', fmt = 'bold' },
  ['@tag.xml'] = { fg = '$cyan', fmt = 'bold' },
  ['@comment.c'] = { fg = '#afd7ff' },
}
local pgl_hl = vim.tbl_deep_extend('force', pwsh_hl, xml_hl)

-- NOTE: UI Colors
local ui_hl = {
  ['WinSeparator'] = { fg = '$cyan' },
  ['StatusLineNC'] = { fg = '$cyan', bg = '$cyan' },
}

local hl = vim.tbl_deep_extend('force', blink_hl, float_hl, markdown_hl, pgl_hl, ui_hl)

local M = {
  'navarasu/onedark.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local onedark = require 'onedark'
    onedark.setup {
      style = 'darker',
      toggle_style_key = '<leader>tsk',
      colors = {
        black = '#282c34',
        red = '#e06c75',
        orange = '#d19a66',
        yellow = '#e5c07b',
        green = '#98c379',
        cyan = '#56b6c2',
        blue = '#61afef',
        purple = '#c678dd',
      },
      highlights = hl,
    }
    onedark.load()
  end,
}

return M
