require("user.telegram") 		-- Requiere la librer�a de usuario
message = 'test message'		-- Texto del mensaje a enviar
res, err = telegram(message) 	-- Se pasa a la biblioteca de usuario el mensaje
log(res, err)
