require 'spec_helper'
require './dominio/gastoequitativo'
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
      grupo = crear_grupo_con_usuarios('casa', 2, MockRepositorioUsuarios.new)
      gasto = described_class.new('supermercado', 500, grupo)
      expect(gasto.monto).to eq 500
    end
  end
end
