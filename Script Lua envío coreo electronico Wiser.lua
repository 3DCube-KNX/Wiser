-- Script en Lua para enviar un e-mail con Wiser
function mail(to, subject, message)
-- Asegurarse que esta configuración es correcta
  local settings = {
-- campo "From/desde", solo una dirección de correo debe ser especificada aquí
    from = 'domocorreoknx@gmail.com,
-- nombre de usuario de la cuenta
    user = domocorreoknx@gmail.com,
-- contraseña de la cuenta
    password = 'e4d050f6df',
-- Nombre del servidor de correo smtp
    server = 'smtp.gmail.com',
-- Puesto del servidor de correo smtp 
    port = 465,
-- Habilitar tls (Transport Security Layer) , necesario para la seguridad de la comunicación con el servidor smtp de gmail
    secure = 'tlsv1_2',
  }

  local smtp = require('socket.smtp')

  if type(to) ~= 'table' then
    to = { to }
  end

  for index, email in ipairs(to) do
    to[ index ] = '<' .. tostring(email) .. '>'
  end

  -- fixup from field
  local from = '<' .. tostring(settings.from) .. '>'

  -- Cabecera y cuerpo del mensaje
  settings.source = smtp.message({
    headers = {
      to = table.concat(to, ', '),
      subject = subject,
      ['From'] = from,
      ['Content-type'] = 'text/html; charset=utf-8',
    },
    body = message
  })

  settings.from = from
  settings.rcpt = to

  return smtp.send(settings)
end
