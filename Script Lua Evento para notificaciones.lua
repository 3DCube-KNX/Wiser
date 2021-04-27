if  value == true then -- Si el valor de la DG es igual a verdadero (1), entonces enviamos la notificaci�n.
require("user.pushover")
title = 'Wiser' --T�tulo del mensaje
message = 'Alarma de viento'--Mensaje a enviar
--Ajustar el sonido que se escuchar� en el dispositivo
--pushover(default), bike, bugle, cashregister, classical, cosmic, falling, gamelan, incoming, intermission, magic, mechanical, pianobar, siren, spacealarm, tugboat, alien, climb, persistent, echo, updown, none
sound = 'updown'
--Definir la prioridad
--(-2 = no notification only badge and message in app, -1 = notification without sound or vibration, 0 = default, 1 = bypass user quiet hours (set in App not iOS), 2 = bypass user quiet hours (set in App not iOS) + acknowledge required
priority = 2 -- Prioridad se salta el silencio de la app por parte del usuario y requiere acuse de recibo
--Segundos para reintentar cuando no se acusa el recibo, minino 30(solo en prioridad 2)
retry = 30 
--Segundos expiraci�n reintento si no hay acuse de recibo, m�ximo = 86400 (24 hrs, solo en prioridad 2)
expire = 3600 
--Env�o de la notificaci�n con los par�metros
pushover(title, message, sound, priority, retry, expire)
end
