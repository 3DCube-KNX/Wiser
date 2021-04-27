-- Obtenemos el valor de la dirección 1/0/1 y se asigna a la variable
value_1 = grp.getvalue('1/0/1')

if value_1 == true then			-- Si el valor de la variable es 1 entonces 
-- Recuperamos el valor actual del contador guardado en el registro (key) y lo asignamos a otra variable				
Stepper_Value = storage.get('Value_Stepper_1')
  if not Stepper_Value then		-- Si la variable vale not, es decir, no existe, entonces
Stepper_Value = 0				-- Inicializamos la variable a 0
end

-- Si el valor de la variable alcanza el mínimo valor, entonces no lo decrementamos más	
  if Stepper_Value == 0 then
else 							-- De lo contrario,		
-- Decrementamos en 1 la variable que almacena el valor actual	
Stepper_Value = Stepper_Value - 1
  end
  
-- Guardamos en el registro el valor de la variable
  storage.set('Value_Stepper_1', Stepper_Value)
-- Se escribe en la dirección de grupo el valor de la variable (total contador)
  grp.write('1/0/6', Stepper_Value)						
end 
