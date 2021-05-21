horario = 'objeto control horario' 	--Objeto asociado al control horario

--Obtenemos la dirección que ha activado el script, la separamos y nos quedamos con su grupo intermedio y subgrupo
tabla_objetos = string.split(event.dst, '/')					

if event.getvalue() == true then	--Si el valor del evento es verdadero entonces
--Escribimos los objetos que han cambiado de estado con el valor del objeto horario
   grp.checkwrite('5/' .. tabla_objetos[2] .. '/' .. tabla_objetos[3], grp.getvalue(horario))	
	
else						--De lo contrario, es decir si el falso

-- Escribimos los objetos que han cambiado con falso					
   grp.checkwrite('5/' .. tabla_objetos[2] .. '/' .. tabla_objetos[3], false)											
end
