-- Librerias necesarias, JSON y Sockets
require('json')									
require('ssl.https')						

-- Datos del usuario
appid = 'b436a'	                            		-- Varaible que contiene la API key
lat = '36.7202'						-- Latitud de la localidad que se desea saber el tiempo, en este caso Málaga
lon ='-4.4203'						-- Latitud de la localidad que se desea saber el tiempo, en este caso Málaga
lang = 'es'						-- Lenguaje, es para la traducción automatica del parametro current.weather.description
units = 'metric'					-- Definicon de las unidades en el sistema metrico

-- Formación de la url y llamada a la API
url = 'https://api.openweathermap.org/data/2.5/onecall?lat=%s&lon=%s&units=%s&lang=%s&appid=%s'		-- Variable que contiene la stringformat
url = string.format(url, lat, lon, units, lang, appid)												-- Función de formateo de string
JSON_Tiempo, error = ssl.https.request(url)															-- Solicitud de informacion con la url completa
log(url, JSON_Tiempo, error)																		-- Registramos la url y el resultado para comprobarlos

-- Decodificacion del JSON en una tabla Lua
Tabla_tiempo = json.pdecode(JSON_Tiempo)																											
																									-- Registramos el contenido completo de la tabla

-- Comprobación de errores
if type(Tabla_tiempo) ~= 'table' then																-- Si el contenido de la variable es distinto a una tabla entonces
  alert('Fallo al cargar la información del tiempo de Openweather')									-- Si la llamada devuelve el codigo de error 401, 404 0 429
elseif Tabla_tiempo.cod == 401 then																														
  alert('Fallo con la llave de la API de Openweather')												-- Mensajes de error
  elseif Tabla_tiempo.cod == 404 then
  alert('Fallo en la solicitud de la API de Openweather')
  elseif Tabla_tiempo.cod == 429 then
  alert('Fallo por exceder el límite de llamasas a la API de Openweather')
  return
end

-- Se asignan a variables los distintos los campos del tiempo actual
Tiempo_actual = Tabla_tiempo.current
log(Tiempo_actual)

--TIEMPO ACTUAL--
-- Temperatura
grp.write('32/2/10', Tiempo_actual.temp)																											
-- Sensación térmica
grp.write('32/2/11', Tiempo_actual.feels_like)

-- Punto de rocio
grp.write('32/2/12', Tiempo_actual.dew_point)

-- Dirección del viento
grp.write('32/2/13', Tiempo_actual.wind_deg)

-- Velocidad del viento
grp.write('32/2/14', Tiempo_actual.wind_speed)

-- Humedad
grp.write('32/2/15', Tiempo_actual.humidity)

-- Presión
grp.write('32/2/16', Tiempo_actual.pressure)

-- ¿Índice UV?
grp.write('32/2/17', Tiempo_actual.uvi)

-- Descripción
grp.write('32/2/18', Tiempo_actual.weather[1].description)

-- Amanecer
amanecer = os.date("%H:%M", Tiempo_actual.sunrise)
grp.write('32/2/19', amanecer)

-- Ocaso
ocaso = os.date("%H:%M", Tiempo_actual.sunset)
grp.write('32/2/20', ocaso)

