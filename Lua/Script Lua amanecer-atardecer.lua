--Obtención de la latitud y la longitud de Wiser
require('uci')										--Librería de acceso a la configuración
latitud = uci.get('genohm-scada.core.latitude') 	--Obtenemos la latitud de la configuración
latitud = tonumber(latitud)							--La convertimos en un numero

longitud = uci.get('genohm-scada.core.longitude')	--Obtenemos la longitud de la configuración
longitud = tonumber(longitud)						--La convertimos en un numero	
log(latitud, longitud)

--Obtenemos de la función común el cálculo del amanecer y el atardecer

amanecer, atardecer = rscalc(latitud, longitud) --Llamada a la función para el cálculo del amanecer y atardecer usando lat/lon (minutos)	
log(amanecer, atardecer)

amanecer_hora = math.floor(amanecer / 60)		--Pasamos de minutos a horas
amanecer_minuto = amanecer % 60					--Calculamos los minutos sobrantes
log(amanecer_minuto)

atardecer_hora = math.floor(atardecer / 60)		--Pasamos de minutos a horas
atardecer_minuto = atardecer % 60				--Pasamos de minutos a horas

--Formateamos el texto del amanecer
amanecer_texto = string.format('%02d:%02d', amanecer_hora, amanecer_minuto) 

--Formateamos el texto del atardecer		
atardecer_texto = string.format('%02d:%02d', atardecer_hora, atardecer_minuto)		
log(amanecer_texto, atardecer_texto)  
