-- Incluir las librerías necesarias
https = require('ssl.https')
json = require('json')
ltn12 = require('ltn12')

payload =  ''

token ='Escriba aquí su token' -- Deje las comillas simples
Token=('Token token=\34'..token..'\34')

-- Obtención de la fecha para la petición
mañana_sin_formato = os.time(os.date('*t')) --+ 86400 	--Hoy más 86400 segundos (+1 día)
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
        ['x-api-key'] = token;

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

--Hora de actualizacion de los datos 
año, mes, dia, hora, minutos, segundos = string.match(data.indicator.values_updated_at, '(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)')
fecha_hora_ordenada = string.format('%s-%s-%s, %s:%s:%s', dia, mes, año, hora, minutos, segundos)
log(fecha_hora_ordenada)

grp.write('32/2/21', fecha_hora_ordenada)

--Utilizamos los datos de la PVCP obtenidos, se divide entre 1000 para obtener kWh--
--Hora 00
grp.write('32/2/22', data.indicator.values[1].value/10)


--Hora 01
grp.write('32/2/23', data.indicator.values[2].value/1000)

-- Hora 24

-- Valor precio:hora más alto y más bajo

values = data.indicator.values -- Guardamos, en una variable, la tabla con solo los valores, esto descarta el resto de la información
log(values)

storage.set('pvpc', values)   -- 

table.sort(values, function(a, b)  -- Se ordena la tabla que contiene los valores de menor valor a máyor valor de precio y se guarda ordenada en value
  return a.value < b.value
end)

min = values[1]                   			-- Se guarda la primera posición de la tabla en la variable min, es una tabla con el precio y la hora
minvalue = min.value/1000               -- Se guarda en la variable, la clave value de la tabla min y se divide entre mill para los kWh. Este es el precio minimo
minhour = min.datetime:match('T(%d+)')  -- Se guarda en la variable, la clave datetime de la tabla min y se quita todo lo que nosea la hora. Esta es la hora

log(minvalue, minhour)

max = values[#values]
log(max)
maxvalue = max.value/1000
maxhour = max.datetime:match('T(%d+)')

log(maxvalue, maxhour)



