$(function() {
  $('.color-por-valor').each(function(_, el) {
    var addr = $(el).data('object');
    if (addr) {
      grp.listen(addr, function(obj) {
        var value = obj.value
          , color = 'blue'; // Color por defecto

        if (value >= 0 && value <= 25) { // Comprobación de coincidencias
          color = 'green';
        }
        else if (value >= 26 && value <= 36) {
          color = 'yellow';
        }
		else if (value >= 37 && value <= 47) {
          color = 'red';
        }
        $(el).css('color', color); // Propiedad CSS que se cambia
      });
    }
  });
});