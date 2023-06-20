require 'spec_helper'
require 'dotenv/load'
require './dominio/gasto_equitativo'
require './dominio/gasto_a_la_gorra'
require './dominio/creador_de_gasto'
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

describe CreadorDeGasto do
  it 'crear gasto equitativo' do
    repositorio_usuarios = MockRepositorioUsuarios.new
    grupo = crear_grupo_con_usuarios('casa', 2, repositorio_usuarios)
    creador = repositorio_usuarios.find_by_telegram_username('user1')
    gasto = described_class.new.crear_gasto('supermercado', 500, grupo, creador, 'equitativo')
    expect(gasto.tipo).to eq 'equitativo'
  end
  it 'crear gasto a la gorra' do
    repositorio_usuarios = MockRepositorioUsuarios.new
    grupo = crear_grupo_con_usuarios('casa', 2, repositorio_usuarios)
    creador = repositorio_usuarios.find_by_telegram_username('user1')
    gasto = described_class.new.crear_gasto('supermercado', 500, grupo, creador, 'gorra')
    expect(gasto.tipo).to eq 'gorra'
  end
  it 'crear gasto erroneo' do
    repositorio_usuarios = MockRepositorioUsuarios.new
    grupo = crear_grupo_con_usuarios('casa', 2, repositorio_usuarios)
    creador = repositorio_usuarios.find_by_telegram_username('user1')
    expect do
      described_class.new.crear_gasto('supermercado', 500, grupo, creador, 'tiza')
    end.to raise_error(TipoDeGastoInexistente)
  end
end
