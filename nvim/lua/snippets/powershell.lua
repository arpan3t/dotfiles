local ls = require 'luasnip'

local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

local s = ls.snippet
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local sn = ls.snippet_node

ls.add_snippets('all', {
  s(
    {
      trig = 'fun',
      name = 'Function',
    },
    fmta(
      [[
function <name> {
    [CmdletBinding()]
    param (
        <finish>
    )
}
            ]],
      {
        name = i(1, 'FunctionName'),
        finish = i(0, 'Finish'),
      }
    )
  ),
})
