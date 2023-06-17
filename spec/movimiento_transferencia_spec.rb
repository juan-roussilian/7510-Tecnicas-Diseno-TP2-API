require 'spec_helper'
require './dominio/movimiento_transferencia'
require './spec/mocks/mock_usuario'
require './spec/mocks/mock_repositorio_usuarios'

describe MovimientoTransferencia do
  describe 'crear movimiento de transferencia' do
    it 'dado un movimiento de transferencia con monto 500 para el usuario user1, obtengo que su monto es 500' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      repositorio_usuarios.delete_all
      repositorio_usuarios.load_example_users(2)
      usuario = repositorio_usuarios.find_by_telegram_username('user1')
      destinatario = repositorio_usuarios.find_by_telegram_username('user2')
      movimiento = described_class.new(usuario, 500, destinatario)
      expect(movimiento.monto).to eq 500
    end
    it 'dado un movimiento de transferencia con monto 400 para el usuario user1, obtengo que su usuario es user1' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      repositorio_usuarios.delete_all
      repositorio_usuarios.load_example_users(2)
      usuario = repositorio_usuarios.find_by_telegram_username('user1')
      destinatario = repositorio_usuarios.find_by_telegram_username('user2')
      movimiento = described_class.new(usuario, 400, destinatario)
      expect(movimiento.usuario.telegram_username).to eq 'user1'
    end
    it 'dado un movimiento de transferencia del usuario user1 al usuario user2, obtengo que su destinatario es user2' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      repositorio_usuarios.delete_all
      repositorio_usuarios.load_example_users(2)
      usuario = repositorio_usuarios.find_by_telegram_username('user1')
      destinatario = repositorio_usuarios.find_by_telegram_username('user2')
      movimiento = described_class.new(usuario, 1000, destinatario)
      expect(movimiento.destinatario.telegram_username).to eq 'user2'
    end
  end
end
