---@class PSESCoreConfig
local M = {}

---@class TransportMethods
local transport_methods = {
  available = {
    'named_pipe',
    'stdio',
  },
  default = 'stdio',
  current = 'stdio',
}

function transport_methods.is_available(method)
  for _, v in ipairs(transport_methods.available) do
    if method == v then
      return true
    end
  end
  return false
end

---@class Features
M.features = {
  -- TODO: Create feature set enum
}

---@class PSESConfig
M.defaults = {}

print(transport_methods.is_available 'named_pipe')
