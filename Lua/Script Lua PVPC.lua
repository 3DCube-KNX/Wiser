-- Incluir las librerías necesarias
https = require('ssl.https')
json = require('json')
ltn12 = require('ltn12')

payload =  ''

token ='4ee20705e6b7c6b05a872d5171a3ba3be1d1936835de7c1722aa02da99356b2a' 
Token=('Token token=\34'..token..'\34')

-- Obtención de la fecha para la petición
mañana_sin_formato = os.time(os.date('*t')) + 86400 	--Hoy más 86400 segundos (+1 día)
mañana_con_formato = os.date("*t", mañana_sin_formato)
dia = mañana_con_formato.day
mes = mañana_con_formato.month
año = mañana_con_formato.year


-- Url donde está el PVPC 2.0TD con su correspondiente indicador 1001 y filtro para solo datos peninsulares
url = 'https://api.esios.ree.es/indicators/1001?start_date='..dia..'-'..mes..'-'..año..'T00%3A00&end_date='..dia..'-'..mes..'-'..año..'T23%3A50&geo_ids[]=8741'

-- Petición
response_body = {}

body, code, hdrs, stat = https.request ({ --Llamada HTTP formada por URL+metodo+cabecera
url = url;
  method = 'GET';
headers = {
        ['Accept'] = 'application/json; application/vnd.esios-api-v1+json'; 
        ['Content-Type'] = 'application/json';
        ['Host'] = 'api.esios.ree.es';
        ['Authorization'] = Token;
        ['Cookie'] = '';
};
    source = ltn12.source.string(payload);
    sink = ltn12.sink.table(response_body);
})

-- Comprobación que la recepción en correcta
if type(response_body) ~= 'table' then											-- Si el contenido de la variable es distinto a una tabla entonces
  alert('Fallo al cargar la información')														
elseif code == 200 then																			-- Si la llamada devuelve el codigo 200, todo OK
  log(code .. ' Datos obtenidos con éxito')
elseif code == 401 then																			-- Si la llamada devuelve el codigo de error 401 o 404																													
  alert(code .. ' Fallo con la llave de la API')						-- Mensajes de error
elseif code == 404 then
  alert(code .. ' Fallo datos no encontrados')
  return
end

-- Tratamiento de los datos recibidos uniéndolos en una sola cadena y decodificando el Json
response = table.concat(response_body)

data = json.pdecode(response)
log(data)

--Hora de actualización de los datos 
año, mes, dia, hora, minutos, segundos = string.match(data.indicator.values_updated_at, '(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)')
fecha_hora_ordenada = string.format('%s-%s-%s, %s:%s:%s', dia, mes, año, hora, minutos, segundos)
grp.write('32/2/21', fecha_hora_ordenada)

--Utilizamos los datos de la PVCP obtenidos, se divide entre 1000 para obtener kWh--
--Hora 00
grp.write('32/2/22', data.indicator.values[1].value/1000)


--Hora 01
grp.write('32/2/23', data.indicator.values[2].value/1000)

