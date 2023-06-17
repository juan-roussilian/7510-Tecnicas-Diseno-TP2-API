require 'spec_helper'
require './dominio/movimiento_pago_de_gasto'
require './spec/mocks/mock_usuario'
require './spec/mocks/mock_repositorio_usuarios'
require './spec/mocks/mock_grupo'
require './spec/mocks/mock_repositorio_grupos'
require './spec/mocks/mock_gasto_equitativo'

describe MovimientoPagoDeGasto do
  describe 'crear movimiento de pago de gasto' do
    it 'dado un movimiento de pago de gasto para el gasto con id 1, obtengo que el id_gasto es 1' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      repositorio_usuarios.delete_all
      repositorio_usuarios.load_example_users(2)
      repositorio_grupos = MockRepositorioGrupos.new
      repositorio_grupos.delete_all
      grupo = MockGrupo.new('casa', 2, repositorio_grupos)
      gasto = MockGastoEquitativo.new('gasto', 500, grupo, 1)
      usuario = repositorio_usuarios.find_by_telegram_username('user1')
      usuario_pagador = repositorio_usuarios.find_by_telegram_username('user2')
      movimiento = described_class.new(usuario, 500, gasto, usuario_pagador)
      expect(movimiento.gasto.id).to eq gasto.id
    end
    it 'dado un movimiento de pago de gasto para el gasto pagado por user2, obtengo que el usuario pagador es user2' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      repositorio_usuarios.delete_all
      repositorio_usuarios.load_example_users(2)
      repositorio_grupos = MockRepositorioGrupos.new
      repositorio_grupos.delete_all
      grupo = MockGrupo.new('casa', 2, repositorio_grupos)
      gasto = MockGastoEquitativo.new('gasto', 500, grupo, 1)
      usuario = repositorio_usuarios.find_by_telegram_username('user1')
      usuario_pagador = repositorio_usuarios.find_by_telegram_username('user2')
      movimiento = described_class.new(usuario, 500, gasto, usuario_pagador)
      expect(movimiento.usuario_pagador.telegram_username).to eq 'user2'
    end
  end
end
