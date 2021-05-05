value = event.getvalue() -- Se obtiene el valor del objeto de escenas y se guarda en la variable value
if (value == 3) then -- Si el valor de la variable value es igual a 3 (número de escena), entonces enviamos el comando de encendido
  if not port then   -- Si el puerto no está ya abierto entonces se abre y configura
    require('serial') --Es necesario incluir la librería de las funciones de comunicación serie
    port, err = serial.open('/dev/RS232', { -- Configuración y apertura del puerto serie
  		baudrate = 9600,
  		databits = 8,
 		 	stopbits = 2,
  		parity = 'none',
  		duplex = 'full'
    		})
    port:flush() --  Limpiar bytes no leídos o enviados
    TV_ON = string.char(0x6B, 0x61, 0x20, 0x30, 0x31, 0x20, 0x30, 0x31, 0x0D) -- Escribir comando encender TV en la variable "TV_ON"
   err = port:write(TV_ON) -- Escribir contenido variable "TV_ON" el puerto serie para encender la TV
   end
   
  ack, err = port:read(10,2) --Leer la confirmación

 	if ack == 'a 01 OK01x' -- Si la respuesta de la TV es OK, entonces
    then grp.write('32/1/3', true) -- Activar objeto estado TV encendida
     elseif ack == 'a 01 NGx'
    then alert('TV error comunicación') 
	end
  
  sleep(5) -- Esperamos a que la TV se encienda.
  
  hdmi1 = string.char(0x78, 0x62, 0x20, 0x30, 0x31, 0x20, 0x39, 0x30, 0x0D) -- Escribir comando cambio entrada HDMI 1
  port:write(hdmi1) -- Escribir contenido variable en el puerto serie para cambio entrada HDMI 1
  ack = port:read(10,2) --Leer la confirmación
  
 	if ack == 'a 01 OK01x' -- Si la respuesta de la TV es OK, entonces
    then grp.write('32/1/4', true) -- Activar objeto estado HDMI1 seleccionado
     elseif ack == 'a 01 NGx'
    then alert('TV error comunicación') 
	end
  port:close() -- Se cierra el puerto serie.    
end




