function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read '*a')
  f:close()
  if raw then
    return s
  end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

-- local url = 'curl -X GET "https://httpbin.org/anything/test" -H "accept: application/json"'
-- local post_cmd = os.capture(url, false)
-- local fname = 'c:/code/temp/pses/service.json'
-- local fcontent = vim.fn.readfile(fname)
-- local json_str = table.concat(fcontent, '\n')
--local json_obj = vim.json.decode(json_str)
-- print(json_obj['languageServicePipeName'])
local file = vim.fn.expand '%:p'
local dir = vim.fn.fnamemodify(file, ':h')
while dir ~= '/' do
  local files = vim.fn.glob(dir .. '/*.csproj', false, true)
  if #files > 0 then
    vim.notify(files[1])
  end
  dir = vim.fn.fnamemodify(dir, ':h')
end
return nil
