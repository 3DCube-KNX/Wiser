$(function(){
   setInterval(function() {
    var WidgetVisible = false;
    $('.layer-widget').each(function( index, element ) {
      if ( $(this).is(':visible') == true) {
        WidgetVisible = true;
      }
    });
    if (WidgetVisible == true){     
      $(".plan").css("opacity", 0.1);
      $(".plan").css("transition", "opacity 0.5s ease-in-out");
      $(".plan").css("-moz-transition", "opacity 0.5s ease-in-out");
      $(".plan").css("webkit-transition", "opacity 0.5s ease-in-out");
      $(".plan-background").css("opacity", 0.1);
      $(".plan-background").css("transition", "opacity 0.5s ease-in-out");
      $(".plan-background").css("-moz-transition", "opacity 0.5s ease-in-out");
      $(".plan-background").css("webkit-transition", "opacity 0.5s ease-in-out");
      $(".layout").css("opacity", 0.1);
      $(".layout").css("transition", "opacity 0.5s ease-in-out");
      $(".layout").css("-moz-transition", "opacity 0.5s ease-in-out");
      $(".layout").css("webkit-transition", "opacity 0.5s ease-in-out");
      $(".layout-background").css("opacity", 0.1);
      $(".layout-background").css("transition", "opacity 0.5s ease-in-out");
      $(".layout-background").css("-moz-transition", "opacity 0.5s ease-in-out");
      $(".layout-background").css("webkit-transition", "opacity 0.5s ease-in-out");
    } else {
      $(".plan").css("opacity", 1);
      $(".plan-background").css("opacity", 1);
      $(".layout").css("opacity", 1);
      $(".layout-background").css("opacity", 1);
    }
  }, 500);      
});