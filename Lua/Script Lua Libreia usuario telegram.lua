require('ssl.https') 			-- Requiere la librería

local token = 'token' 			-- Su API Token
local chat_id = '1234567'		 -- Su ID de chat

function telegram(message)
  local telegram_url = 'https://api.telegram.org/bot' .. token .. '/sendMessage?'
  message=socket.url.escape(message)
  local data_str = 'chat_id=' .. chat_id .. '&text=' .. message..''
  local res, code, headers, status = ssl.https.request(telegram_url, data_str)
end
