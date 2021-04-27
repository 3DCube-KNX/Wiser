if not mb then -- abro la comunicación
require('luamodbus')
mb = luamodbus.rtu() 
mb:open('/dev/RS485', 19200, 'E', 8, 1, 'H')-- configurar la red modbus por RS485 
-- 19200 velocidad de transmisión (330,600,1200,4800,9600,19200,38400,57600,115200,230400)
--'E' even, 'O' Odd, 'N' None
-- 8 Numero de bits de dato : 5, 6, 7 u 8
-- 1 Numero de bits de stop : 1 o 2
-- Tipo de comunicación "H" Half duplex o 'F' Full duplex
mb:connect()
end 
mb:setslave(1) -- (1) Nº de esclavo de la red modbus o direccion modbus del dispositivo a leer
mb:flush() 

local V1,V2,V3, I1,I2,I3,W,VAR,VA, frecuencia, FP -- definición de variables

frecuencia = mb:readregisters(1019)-- registro 1020 frecuencia de red de la PM 
grp.write('1/5/0',frecuencia)-- escribo el valor de frecuencia en la direccion de grupo KNX de frecuencia de la PM1
 
V1 = mb:readregisters(1059)-- registro 1060 tension V1-N de la PM 
grp.write('1/5/1',V1)-- escribo el valor de la tensión en la direccion de grupo KNX de tensión V1-N de la PM1

V2 = mb:readregisters(1061)-- registro 1062 tension V2-N de la PM 
grp.write('1/5/2',V2)-- escribo el valor de la tensión en la direccion de grupo KNX de tensión V2-N de la PM1

V3 = mb:readregisters(1063)-- registro 1064 tension V3-N de la PM 
grp.write('1/5/3',V3)-- escribo el valor de la tensión en la direccion de grupo KNX de tensión V3-N de la PM1

I1 = mb:readregisters(1033)-- registro 1034 Intensidad I1 de la PM 
grp.write('1/5/4',I1)-- escribo el valor de la Intensidad en la direccion de grupo KNX de la Intensidad I1 de la PM1

I2 = mb:readregisters(1035)-- registro 1036 Intensidad I2 de la PM 
grp.write('1/5/5',I2)-- escribo el valor de la Intensidad en la direccion de grupo KNX de la Intensidad I2 de la PM1

I3 = mb:readregisters(1037)-- registro 1038 Intensidad I3 de la PM 
grp.write('1/5/6',I3)-- escribo el valor de la Intensiddad en la direccion de grupo KNX de la Intensidad I3 de la PM1

W = mb:readregisters(1005)-- registro 1006 Potencia activa de la PM 
grp.write('1/5/7',W)-- escribo el valor de la potencia activa en la direccion de grupo KNX de la potencia activa de la PM1

VAR = mb:readregisters(1009)-- registro 1010 Potencia reactiva de la PM 
grp.write('1/5/8',VAR)-- escribo el valor de la potencia reactiva en la direccion de grupo KNX de la potencia reactiva de la PM1

VA = mb:readregisters(1007)-- registro 1008 Potencia aparente de la PM 
grp.write('1/5/9',VA)-- escribo el valor de la potencia aparente en la direccion de grupo KNX de la potencia aparente de la PM1

FP = mb:readregisters(1011)-- registro 1012 Factor de potencia de la PM 

if FP == nil then --FP = FP / 100 -- divido el resultado entre 100 para mostrar un decimal.
  grp.write('1/5/10',FP)
  else
  FP = FP / 100
  grp.write('1/5/10',FP) --grp.write('1/5/10',FP)-- escribo el valor del factor de potencia en la dirección de grupo KNX de la factor de potencia de la PM1
end



