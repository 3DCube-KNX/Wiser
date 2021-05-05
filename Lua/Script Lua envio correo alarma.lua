-- Este script permite que si el valor de la DG es 1 se envíe al correo avisando de la alarma y si es un 0 no se envíe nada

value = event.getvalue() -- obtenemos el valor (0 o 1) del evento, es decir de la DG y lo guardamos en la variable llamada value

if value == true then --Si la variable value es igual a true (verdadero = 1), then (entonces) que se envíe el mensaje
subject = 'Alarma de inundación'
message = 'Se ha producido una alarma de inundación'
mail('domocorreoknx@gmail.com', subject, message) –-Así usamos el mismo correo para enviar y recibir los mensajes de alarma.

else -- De otro modo, hacer lo que viene después, como no se desea hacer ninguna función pues no se pone nada
  dosomething() -- En el caso de querer enviar un correo con un asunto y mensaje diferente cuando la DG no sea 1, es decir sea 0, poner subject, message y mail.
end







