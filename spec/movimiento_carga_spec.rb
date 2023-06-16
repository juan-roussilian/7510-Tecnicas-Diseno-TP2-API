require 'spec_helper'
require './dominio/movimiento_carga'
require './spec/mocks/mock_usuario'
require './spec/mocks/mock_repositorio_usuarios'

describe MovimientoCarga do
  describe 'crear movimiento de carga' do
    it 'dado un movimiento de carga con monto 500 para el usuario user1, obtengo que su monto es 500' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      repositorio_usuarios.delete_all
      repositorio_usuarios.load_example_users(1)
      usuario = repositorio_usuarios.find_by_telegram_username('user1')
      movimiento = described_class.new(usuario, 500)
      expect(movimiento.monto).to eq 500
    end
  end
end
