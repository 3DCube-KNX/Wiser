--Primero obtener la hora como una tabla y asignala a la variable now
    now = os.date('*t')
     
-- El día de la semana empieza en domingo y he de convertirlo al formato KNX que empieza en lunes
    wday = now.wday == 1 and 7 or now.wday - 1
-- Tabla de hora en la variable time
    time = { 
    day = wday,
    hour = now.hour, 
    minute = now.min,
    second = now.sec,
    }
     
-- Tabla de fecha en la variable date
    date = {
    day = now.day, 
    month = now.month,
    year = now.year,
    }
-- actualizar el valor de la dirección de grupo, con la tabla time, dt.time y dt.date son los DPTs correspondientes 
    grp.update('1/2/14', time, dt.time)
    grp.update('1/2/15', date, dt.date)
  

