-- Este script averigua la IP p�blica y la guarda en 0/0/1.

ip = require('ssl.https').request('https://openrb.com/ip/')
if ip then
  grp.checkupdate('0/0/1', ip:trim())
end

