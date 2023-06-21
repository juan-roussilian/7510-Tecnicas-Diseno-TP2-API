# argumentos = { key: @api_key, q: @ciudad_bonificada, aqi: 'no' }
# respuesta = Faraday.get(@api_url, argumentos)
# if respuesta.status == STATUS_CODE_OK
#   info_clima = JSON.parse(respuesta.body)
#   lluvia = info_clima['current']['precip_mm'] >= MILIMTEROS_MINIMOS_LLUVIA
#   fecha = Date.parse info_clima['location']['localtime']
#   return saldo * @coeficiente_bonificacion if fecha.sunday? && lluvia
# end
