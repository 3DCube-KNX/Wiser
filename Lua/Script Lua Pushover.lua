require 'ssl.https' -- Librería necesaria para que el script funcione
 
local pushover_url = 'https://api.pushover.net/1/messages.json'
local token = 'COPIE EL API TOKEN AQUÍ' -- Aquí se debe copiar el API Token.
local user = 'COPIE EL USER TOKEN AQUÍ' -- Aquí se debe copiar el USER Token.
function pushover(title, message, sound, priority, retry, expire)
     if priority < -2 then priority = -2 end
     if priority > 2 then priority = 2 end      
     if retry < 30 then retry = 30 end
     if retry > 86400 then retry = 86400 end
     if expire < retry then expire = retry end
     if expire > 86400 then expire = 86400 end
     if priority == 2 then prioritystring = ''.. priority .. '&retry=' .. retry .. '&expire=' .. expire ..'' else prioritystring = priority end     
     now = os.date('*t')
     timestamp = string.format('%02d', now.day) .. '-' .. string.format('%02d', now.month) .. '-' .. now.year .. ' ' ..  string.format('%02d', now.hour) .. ':' .. string.format('%02d', now.min) .. ':' .. string.format('%02d', now.sec)
     local data_str = 'user=' .. user .. '&message=' .. message .. ' ' .. timestamp .. '&token=' .. token .. '&title=' .. title  .. '&sound=' .. sound .. '&priority=' .. prioritystring .. ''
     local res, code, headers, status = ssl.https.request(pushover_url, data_str)
end
