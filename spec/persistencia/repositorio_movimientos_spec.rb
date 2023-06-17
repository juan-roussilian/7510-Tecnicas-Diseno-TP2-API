require 'integration_helper'
require_relative '../../dominio/movimiento_carga'
require_relative '../../dominio/movimiento_transferencia'
require_relative '../../dominio/movimiento_pago_de_gasto'
require_relative '../../persistencia/repositorio_movimientos'
require './spec/mocks/mock_repositorio_usuarios'
require './spec/mocks/mock_repositorio_grupos'
describe RepositorioMovimientos do
  it 'deberia guardar y asignar un id a un nuevo movimiento de carga' do
    described_class.new.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    repositorio_usuarios.delete_all
    repositorio_usuarios.load_example_users(2)
    user1 = repositorio_usuarios.find_by_telegram_username('user1')
    movimiento_carga = MovimientoCarga.new(user1, 100)
    described_class.new.save(movimiento_carga)
    expect(movimiento_carga.id).not_to be_nil
  end
end
