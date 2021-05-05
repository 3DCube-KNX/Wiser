-- Inicializar variables
value_1 = grp.getvalue('1/0/0')	-- El valor del objeto se guarda en la variable value 1
value_2 = grp.getvalue('1/1/2')	-- El valor del objeto se guarda en la variable value 2
--Si en la variable value 1 es mayor o igual al valor de value 2, entonces
if value_1 >= value_2 then
grp.write('1/0/3', true)	-- Se escribe 1 (true) en la dirección de grupo de salida
else						-- De lo contrario, es decir en cualquier otro caso
grp.write('1/0/3', false)	-- Se escribe 1 (false) en la dirección de grupo de salida
end 
 
