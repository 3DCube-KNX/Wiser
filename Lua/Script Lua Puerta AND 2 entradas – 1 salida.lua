-- Inicializar variables
value_1 = grp.getvalue('1/0/0') -- El valor del objeto y se guarda en la variable value 1
value_2 = grp.getvalue('1/0/1') -- El valor del objeto y se guarda en la variable value 2

--Si en la variable value 1 es igual a 1 (true) y la variable value 2 es igual a 1, entonces
if value_1 == true and value_2 == true then 
grp.write('1/0/2', true) 	-- Se escribe 1 (true) en la dirección de grupo de salida
else -- De lo contrario, es decir en cualquier otro caso
grp.write('1/0/2', false)  	-- Se escribe 0 (false) en la dirección de grupo de salida  
end 
