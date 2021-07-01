$(function() {
  
  // Vuelta al inicio despues de x segundos (en miliseguntos)
  var SE_Timeout = 90000; // Ajustar el valor de espera (90 seconds en miliseguntos)
  var SE_Startpage = currentPlanId; // Primera página que se carga
  var eventlist = 'vclick vmousedown vmouseout touchend';
  
  // Funcion para la deteccion del tiempo sin usar
  function No_Usage_Detected(callback, timeout, _this) {
    var timer;
    return function(e) {
        var _that = this;
        if (timer)
            clearTimeout(timer);
        timer = setTimeout(function() { 
            callback.call(_this || _that, e);
        }, timeout);
    }
  }

  // Función de volver cuando pasa el tiempo
    var SE_Goto_Startpage = No_Usage_Detected(function(e) {
    if ( currentPlanId != SE_Startpage ) {
    showPlan(SE_Startpage);
    }
  }, SE_Timeout);
  
  // Se añadeun detector de eventos al documento para detectar la entrada del usuario
  $(document)
  .on(eventlist, function() {
    SE_Goto_Startpage();
  });
 
  // Se agrega un detector de eventos a todos los iframes para detectar la entrada del usuario dentro de ellos
  $('iframe').load(function() {
    var iframe = $('iframe').contents().find('html');
    iframe.on(eventlist, function(event) {
     SE_Goto_Startpage();
    });
  });

});
