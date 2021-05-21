--Recorremos todos los objetos que tengan la etiqueta Entrada y todos se añaden como tablas a la variable objetos
for indice, objetos in pairs(grp.tag('Entrada')) do

--Separamos la cadena contenida en address con el delimitador /, de esta manera nos quedamos solo con el grupo intermedio/subgrupo
  tabla_objetos = string.split(objetos.address, '/')	
	
--Si el valor del objeto es 1 entonces
  if objetos.value == true then
	
  --Escribimos los solo los objetos de las cargas que han cambiado, empezando por el grupo principal especificado y por los grupos intermedios y subgrupos obtenidos de los objetos virtuales que están en la variable tabla_objetos
     grp.checkwrite('Grupo principal/' .. tabla_objetos[2] .. '/' .. tabla_objetos[3], event.getvalue())	
  end
end
