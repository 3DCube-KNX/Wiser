$(function() {
  grp.listen('objeto de estado posición persiana', function(obj) {
    $('.persianas').height(10 + obj.value * 2);
  });
});
