-- Incluir las librerías necesarias
https = require('ssl.https')
json = require('json')
ltn12 = require('ltn12')

payload =  ''

token ='su token' 
Token=('Token token=\34'..token..'\34')

-- Obtención de la fecha para la petición
tom = os.time(os.date('*t')) + 86400 	--Hoy más 86400 segundos (+1 día)
tomorrow = os.date("*t", tom)
day = tomorrow.day
month = tomorrow.month
year = tomorrow.year


-- Url donde está el PVPC con su correspondiente indicador 10229
url = 'https://api.esios.ree.es/indicators/10229?start_date='..day..'-'..month..'-'..year..'T00%3A00&end_date='..day..'-'..month..'-'..year..'T23%3A50' --Término de facturación de energía activa del PVPC

-- Petición
response_body = {}
  
body, code, hdrs, stat = https.request ({
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
if type(response_body) ~= 'table' then												-- Si el contenido de la variable es distinto a una tabla entonces
  alert('Fallo al cargar la información')														
elseif code == 200 then																	-- Si la llamada devuelve el codigo 200, todo OK
  log(code .. ' Datos obtenidos con éxito')
elseif code == 401 then																	-- Si la llamada devuelve el codigo de error 401 o 404																													
  alert(code .. ' Fallo con la llave de la API')										-- Mensajes de error
elseif code == 404 then
  alert(code .. ' Fallo datos no encontrados')
  
  return
end

-- Tratamiento de los datos recibidos uniéndolos en una sola cadena y decodificando el Json
response = table.concat(response_body)
data = require('json').decode(response)

--Utilizamos los datos de la PVCP obtenidos, se divide entre 1000 para obtener kWh--
--Hora 00
grp.write('32/2/21', data.indicator.values[ 1 ].value/1000)


--Hora 01
grp.write('32/2/22', data.indicator.values[ 2 ].value/1000)
