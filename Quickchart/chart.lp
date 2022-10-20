<?

require('apps')

local data = storage.get('pvpc')


local labels = {}

for i = 0, 23 do
  local label = tostring(i)
  if #label == 1 then
    label = '0' .. label
  end

  labels[ #labels + 1 ] = label
end

for i, item in ipairs(data) do
  data[ i ] = item.value / 1000
end

local width = 600
local height = 400

local params = {
  type = 'line',
  data = {
    labels = labels,
    datasets = {
      {
        label = 'Prices',
        backgroundColor = 'rgb(255, 99, 132)',
        borderColor = 'rgb(255, 99, 132)',
        data = data,
        fill = false,
      }
    }
  },
  options = {
    title = {
      display = true,
      text = 'Title',
    }
  }
}

local cdata = ngx.escape_uri(require('json').encode(params))
local url = 'https://quickchart.io/chart?w=' .. width .. '&h=' .. height .. '&c=' .. cdata

local data = require('socket.http').request(url)

header('content-type', 'image/png')
write(data)


