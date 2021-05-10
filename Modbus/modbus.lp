<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="/apps/css/bootstrap.css">
</head>
<body>
<table class="table table-striped">
<tr>
  <th>Fecha/hora</th>
  <th>Tipo de Error</th>
</tr>
<?
require('apps')

items = db:getall([[
  SELECT * FROM modbus_errors
  ORDER BY errortime DESC
  LIMIT 50
]])

for _, item in ipairs(items) do
  datetime = os.date('%d.%m.%Y %H:%M:%S', item.errortime)
?>
<tr>
  <td><?=datetime?></td>
  <td><?=escape(item.errortext)?></td>
</tr>
<? end ?>
</table>
</body>
</html>
