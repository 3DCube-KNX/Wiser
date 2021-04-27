-- Inicializar variables
value = event.getvalue()	-- El valor del evento se guarda en la variable value

if value == true then		-- Si la variable valor es igual a 1 (true), entonces
grp.write('1/0/6', 100)		-- Se escribe el valor 100 en la dirección de grupo de salida de 1 byte
else						-- De lo contrario, es decir si es 0 (false)
grp.write('1/0/6', 0)		-- Se escribe el valor 0 en la dirección de grupo de salida de 1 byte
end

