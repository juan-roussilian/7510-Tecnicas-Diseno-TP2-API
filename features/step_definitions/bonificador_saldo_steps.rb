require './spec/mocks/mock_consultor_clima_lluvioso'
require './spec/mocks/mock_consultor_clima_sin_lluvia'

Dado('el dia es domingo') do
  @proveedor_fecha = ProveedorFecha.new('2023-06-18')

end

Dado('el dia es lunes') do
  @proveedor_fecha = ProveedorFecha.new('2023-06-19')
end
Dado('el dia es martes') do
  @proveedor_fecha = ProveedorFecha.new('2023-06-20')
end

Dado('el clima es lluvia') do
  @proveedor_clima = ProveedorClima.new(MockConsultorClimaLluvioso.new) 
end

Dado('el clima es soleado') do
  @proveedor_clima = ProveedorClima.new(MockConsultorClimaSinLluvia.new) 
end

Cuando('cargo un monto de {float}') do |saldo|
  repositorio_usuarios = RepositorioUsuarios.new
  repositorio_movimientos = RepositorioMovimientos.new
  bonificador = Bonificador.new(@proveedor_fecha, @proveedor_clima)
  @usuario.cargar_saldo(saldo, repositorio_usuarios, repositorio_movimientos, bonificador)
end

Entonces('mi saldo es de {float}') do |saldo_esperado|
  saldo = JSON.parse(Faraday.get(get_url_for('/saldo'),{ usuario: @usuario.telegram_id } ).body)['saldo']
  expect(saldo).to eq saldo_esperado
end
  