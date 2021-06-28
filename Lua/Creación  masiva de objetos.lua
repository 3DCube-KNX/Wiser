address = buslib.encodega('32/2/22') --Convierte la dirección de grupo en un numero
for i = 1, 24 do 			--Bucle que empieza en 1 y termina en 24
  grp.create({			--Función de creación de objetos
    address = address,		--Es la dirección del objeto que vamos incrementando
    datatype = dt.float32,		--Tipo de datos necesario (coma flotante de 32 bits)
    name = 'Hora ' .. i,		--Nombre con testo "hora" y el índice del bucle
    units = 'kWh',			--Unidad
    tags = "PVPC",			--Etiqueta
	visparams = {			--Parámetros de visualización del objeto
    	decimals = '5'		--Usar 5 decimales
		},
  })
    address = address + 1		--Incrementamos en una unidad el número de la DG
end
