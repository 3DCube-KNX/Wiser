$(function(){
  if (typeof grp != 'undefined') {
    grp.listen('32/2/46', function(object, state) { 
      var value = object.value; //Declaracion  de la variable y asignacion del valor del objeto
      if (state == 'value') {
        if (value == 1) { 	//si el valor del objeto es 1
          showPlan(3);		// Muestra la página indicada
        }
        else if (value == 2) {
          showPlan(4);
        }
        else if (value == 3) {
          showPlan(12);
        }
      }
    });
  }
});
