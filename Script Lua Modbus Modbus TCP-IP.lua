--Crear un objeto Modbus
require('luamodbus')
mb = luamodbus.tcp() 

--Abrir la comunicacion modbus a la IP del esclavo y con el puerto 502
mb:open('192.168.0.12', 502)
mb:connect()

-- Vacía los bytes leídos / no enviados, devuelve el resultado de la operación de vaciado.
mb:flush()

-- Definición de variables
local Registro_1, Registro_2

-- Leer dos registros desde la direccion 0 y guardar en orden en las variables
Registro_1, Registro_2 = mb:readregisters(0, 2)

-- escribir el registro en la direccion de grupo virtual
grp.write('32/1/1',Registro_1)

-- escribir el registro en la direccion de grupo virtual
grp.write('32/1/2',Registro_2)





