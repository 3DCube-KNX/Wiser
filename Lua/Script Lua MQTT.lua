-- Abrir comunicación.
if not broker then
  socket = require('socket')
  json = require('json')

-- Dirección IP donde esté instalado el broker.
  broker = 'Dirección IP del Broker'
  port = '1883'

  -- Usuario y contraseña definida en el archivo pw.txt
  username = 'Usuario'
  password = 'contraseña'
  
  --Mapeo del valor del topic MQTT al objeto del wiser (cambiar nombre del topic, del objeto y repetirlo para cada objeto que se quiere usar). 
  mqtt_to_object = {
    ['in/topic1'] = {
      addr = '1/0/0',
      convert = json.pdecode,
    },
    ['in/topic2'] = {
      addr = '1/0/19',
    }
  }

  --Mapeo del valor del objeto del wiser al topic MQTT  (cambiar nombre del topic, del objeto y repetirlo para cada objeto que se quiere usar). 
  object_to_mqtt = {
    ['1/0/0'] = {
      topic = 'out/topic1',
      qos = 1,
      retain = true,
      convert = json.encode,
    },
    ['1/0/19'] = {
      topic = 'out/topic2',
    }
  }

  datatypes = {}

  grp.sender = 'mq'

  for addr, _ in pairs(object_to_mqtt) do
    local obj = grp.find(addr)
    if obj then
      datatypes[ addr ] = obj.datatype
    end
  end

  mclient = require('mosquitto').new()

  mclient.ON_CONNECT = function(res, ...)
    log('mqtt connect status', res, ...)

    if res then
      for topic, _ in pairs(mqtt_to_object) do
        mclient:subscribe(topic)
      end
    else
      mclient:disconnect()
    end
  end

  mclient.ON_MESSAGE = function(mid, topic, payload)
    local map = mqtt_to_object[ topic ]
    if map then
      if map.convert then
        payload = map.convert(payload)
      end

      grp.write(map.addr, payload)
    end
  end

  mclient.ON_DISCONNECT = function(...)
    log('mqtt disconnect', ...)
    mclientfd = nil
  end

  function mconnect()
    local status, rc, msg, fd

    status, rc, msg = mclient:connect(broker, port)

    if not status then
      log('mqtt connect failed ' .. tostring(msg))
    end

    fd = mclient:socket()
    if fd then
      mclientfd = fd
    end
  end
  -- Desactivacion dl cifrado TLS.
  mclient:tls_insecure_set(false)
  mclient:login_set(username, password or '')

  mconnect()

  function publishvalue(event)
    -- message from us or client is not connected
    if event.sender == 'mq' or not mclientfd then
      return
    end

    local addr = event.dst
    local dpt = datatypes[ addr ]
    local map = object_to_mqtt[ addr ]

    -- unknown object
    if not dpt or not map then
      return
    end

    local value = busdatatype.decode(event.datahex, dpt)
    if value ~= nil then
      if map.convert then
        value = map.convert(value)
      elseif type(value) == 'boolean' then
        value = value and 1 or 0
      end

      mclient:publish(map.topic, tostring(value), map.qos or 0, map.retain)
    end
  end

  lbclient = require('localbus').new(1)
  lbclient:sethandler('groupwrite', publishvalue)

  lbclientfd = socket.fdmaskset(lbclient:getfd(), 'r')

  -- run timer every 5 seconds
  timer = require('timerfd').new(5)
  timerfd = socket.fdmaskset(timer:getfd(), 'r')
end

-- mqtt connected
if mclientfd then
  mclientfdset = socket.fdmaskset(mclientfd, mclient:want_write() and 'rw' or 'r')
  res, lbclientstat, timerstat, mclientstat =
      socket.selectfds(10, lbclientfd, timerfd, mclientfdset)
-- mqtt not connected
else
  res, lbclientstat, timerstat =
    socket.selectfds(10, lbclientfd, timerfd)
end

if mclientstat then
  if socket.fdmaskread(mclientstat) then
    mclient:loop_read()
  end

  if socket.fdmaskwrite(mclientstat) then
    mclient:loop_write()
  end
end

if lbclientstat then
  lbclient:step()
end

if timerstat then
  -- clear armed timer
  timer:read()

  if mclientfd then
    mclient:loop_misc()
  else
    mconnect()
  end
end
