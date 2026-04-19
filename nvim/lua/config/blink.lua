local kind_icons = {
  Class = ' ',
  Color = ' ',
  Constant = ' ',
  Constructor = ' ',
  Enum = ' ',
  EnumMember = ' ',
  Event = ' ',
  Field = ' ',
  File = ' ',
  Folder = ' ',
  Function = ' ',
  Interface = ' ',
  Keyword = ' ',
  Method = ' ',
  Module = ' ',
  Operator = ' ',
  Parameter = ' ',
  Property = ' ',
  Reference = ' ',
  Snippet = ' ',
  Struct = ' ',
  Text = ' ',
  TypeParameter = ' ',
  Unit = ' ',
  Value = ' ',
  Variable = ' ',
}

-- NOTE: Adds support for PowerShell parameter completion
local function pses_cmp(ctx, opts)
  local is_pses = vim.bo.filetype == 'ps1'
  if is_pses == false then
    return ctx[opts]
  end

  local ft = ctx.item.filterText

  if ft ~= nil and ft:match '^%-' then
    if opts == 'kind_icon' then
      ctx[opts] = kind_icons['Parameter']
    elseif opts == 'kind' then
      ctx[opts] = 'Parameter'
    end
  end

  return ctx[opts]
end

---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
  keymap = {
    preset = 'default',
  },
  appearance = {
    nerd_font_variant = 'mono',
    kind_icons = kind_icons,
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = 'rounded',
      },
    },
    menu = {
      border = 'rounded',
      draw = {
        columns = {
          { 'label' },
          { 'kind_icon', 'kind' },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              return pses_cmp(ctx, 'kind_icon')
            end,
          },
          kind = {
            text = function(ctx)
              return pses_cmp(ctx, 'kind')
            end,
          },
        },
      },
    },
  },
  snippets = {
    preset = 'luasnip',
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}

return opts
