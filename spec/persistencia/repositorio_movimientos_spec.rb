require 'integration_helper'
require_relative '../../dominio/movimiento_carga'
require_relative '../../dominio/movimiento_transferencia'
require_relative '../../dominio/movimiento_pago_de_gasto'
require_relative '../../persistencia/repositorio_movimientos'
require './spec/mocks/mock_repositorio_usuarios'
require './spec/mocks/mock_repositorio_grupos'

def cargar_usuarios_ejemplo(numero_de_usuarios, repositorio)
  (0..numero_de_usuarios).each do |i|
    repositorio.save(Usuario.new("usuario#{i}", "test#{i}@test.com", i.to_s, "user#{i}"))
  end
end
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

  it 'deberia guardar y traer correctamente un movimiento de transferencia' do
    described_class.new.delete_all
    repositorio_usuarios = RepositorioUsuarios.new
    repositorio_usuarios.delete_all
    cargar_usuarios_ejemplo(2, repositorio_usuarios)
    usuario = repositorio_usuarios.find_by_telegram_username('user1')
    destinatario = repositorio_usuarios.find_by_telegram_username('user2')
    movimiento_transferencia = MovimientoTransferencia.new(usuario, 100, destinatario)
    repositorio_movimientos = described_class.new
    repositorio_movimientos.save(movimiento_transferencia)
    movimiento_validar = repositorio_movimientos.find(movimiento_transferencia.id)
    expect(movimiento_validar.usuario.id).to eq usuario.id
    expect(movimiento_validar.destinatario.id).to eq destinatario.id
  end
end
