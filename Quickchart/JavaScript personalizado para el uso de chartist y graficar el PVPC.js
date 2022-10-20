$(function() {
  $.getJSON('/user/data.lp', function(data) {
    var labels = [];

    for (var i = 0; i < 24; i++) {
      var label = i.toString();
      if (label.length == 1) {
        label = '0' + label;
      }

      labels.push(label);
    }

    for (var i = 0; i < data.length; i++) {
      data[ i ] = data[ i ].value / 1000;
    }
// Alto y ancho de la gráfica
    var width = 600; 
    var height = 400;

// Parámetros de la gráfica, tipo linea, colores, datos y sin relleno.   
    var params = {
      type: 'line',
      data: {
        labels: labels,
        datasets: [
          {
            label: 'Precio',
            backgroundColor: 'rgb(255, 99, 132)',
            borderColor: 'rgb(255, 99, 132)',
            data: data,
            fill: false,
          },
        ]
      },
      options: {
        title: {
          display: true,
          text: 'PVPC',
        },
      },
    };
    
    var cdata = encodeURIComponent(JSON.stringify(params));
    var src = 'https://quickchart.io/chart?w=' + width + '&h=' + height + '&c=' + cdata;
 // Posición y página de la visualización    
    $('<img>').css({
      position: 'absolute',
      width: width + 'px',
      height: height + 'px',
      left: '10px',
      top: '50px',
      zIndex: 999
    }).appendTo('#plan-8').attr('src', src);
  });
});