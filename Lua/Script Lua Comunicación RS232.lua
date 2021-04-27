-- Se obtiene el valor del objeto de escenas y se guarda en la variable value
value = event.getvalue()

-- si el valor de la variable value es igual a 3 (número de escena), entonces enviamos el comando de encendido
if (value == 3) then
  
  -- Es necesario incluir la librería de las funciones de comunicación serie
    if not port then 
    require('serial')
    -- Configuración y apertura del puerto serie
    port = serial.open('/dev/RS232', {
  baudrate = 9600,
  databits = 8,
  stopbits = 1,
  parity = 'none',
  duplex = 'full'
    })
    --  Limpiar bytes no leídos o enviados
    port:flush()  
    -- Escribir datos en el puerto serie para encender la TV
    msg = string.char(0x6B, 0x61, 0x20, 0x30, 0x31, 0x20, 0x30, 0x31, 0x0D)
    port:write(msg)
    log (msg)
    port:close()
    end
end

