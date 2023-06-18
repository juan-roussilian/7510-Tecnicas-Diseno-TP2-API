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
  it 'deberia guardar y traer correctamente un movimiento de pago de gasto' do
    described_class.new.delete_all
    repositorio_usuarios = RepositorioUsuarios.new
    repositorio_usuarios.delete_all
    cargar_usuarios_ejemplo(2, repositorio_usuarios)
    usuario_principal = repositorio_usuarios.find_by_telegram_username('user1')
    usuario_pagador = repositorio_usuarios.find_by_telegram_username('user2')
    repositorio_grupos = RepositorioGrupos.new
    repositorio_grupos.delete_all
    grupo = Grupo.new('grupo1', [usuario_principal, usuario_pagador], repositorio_grupos)
    repositorio_grupos.save(grupo)
    repositorio_gastos = RepositorioGastos.new
    repositorio_gastos.delete_all
    gasto = GastoEquitativo.new('gasto1', 100, grupo, usuario_principal)
    repositorio_gastos.save(gasto)
    movimiento_pago_de_gasto = MovimientoPagoDeGasto.new(usuario_principal, 50, gasto, usuario_pagador)
    repositorio_movimientos = described_class.new
    repositorio_movimientos.save(movimiento_pago_de_gasto)
    movimiento_validar = repositorio_movimientos.find(movimiento_pago_de_gasto.id)
    expect(movimiento_validar.usuario.id).to eq usuario_principal.id
    expect(movimiento_validar.gasto.id).to eq gasto.id
    expect(movimiento_validar.usuario_pagador.id).to eq usuario_pagador.id
  end
end
