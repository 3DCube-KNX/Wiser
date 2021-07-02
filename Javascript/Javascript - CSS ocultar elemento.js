$(function(){
   grp.listen('Objeto a utilizar', function(object, state) {
      if (state == 'value' && object.value == true) {
         $(".ocultar-via-knx").addClass("hide");
      } else if (state == 'value' && object.value == false) {
         $(".ocultar-via-knx").removeClass("hide");
      }
   }, true);
});