require 'spec_helper'
require './dominio/gasto_equitativo'
require './spec/mocks/mock_usuario'
require './spec/mocks/mock_grupo'
require './spec/mocks/mock_repositorio_usuarios'

def crear_grupo_con_usuarios(nombre, cantidad, repositorio_usuarios, repositorio_grupos = nil)
  repositorio_usuarios.load_example_users(cantidad)
  usuarios = []
  cantidad.times do |i|
    usuarios << repositorio_usuarios.find_by_telegram_username("user#{i + 1}")
  end
  grupo = Grupo.new(nombre, usuarios, repositorio_grupos)
  repositorio_grupos&.save(grupo)
  grupo
end

describe GastoEquitativo do
  describe 'crear gasto' do
    it 'dado un gasto con nombre supermercado y monto 500 para el grupo casa, obtengo que su monto es 500' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      grupo = crear_grupo_con_usuarios('casa', 2, repositorio_usuarios)
      creador = repositorio_usuarios.find_by_telegram_username('user1')
      gasto = described_class.new('supermercado', 500, grupo, creador)
      expect(gasto.monto).to eq 500
    end
    it 'dado un gasto equitativo con monto 500 para un grupo de 2 usuarios, obtengo que la deuda de cada uno es 250' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      grupo = crear_grupo_con_usuarios('casa', 2, repositorio_usuarios)
      creador = repositorio_usuarios.find_by_telegram_username('user1')
      gasto = described_class.new('almacen', 500, grupo, creador)
      expect(gasto.deuda_por_usuario).to eq 250
    end
  end
end
