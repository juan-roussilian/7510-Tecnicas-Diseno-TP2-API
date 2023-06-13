require 'integration_helper'
require_relative '../../dominio/gasto_equitativo'
require_relative '../../persistencia/repositorio_gastos'
require './spec/mocks/mock_repositorio_usuarios'
require './spec/mocks/mock_repositorio_grupos'
describe RepositorioGastos do
  it 'deberia guardar y asignar un id a un nuevo gasto' do
    described_class.new.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    repositorio_usuarios.delete_all
    repositorio_usuarios.load_example_users(2)
    user1 = repositorio_usuarios.find_by_telegram_username('user1')
    user2 = repositorio_usuarios.find_by_telegram_username('user2')
    repositorio_grupos = MockRepositorioGrupos.new
    repositorio_grupos.delete_all
    grupo = Grupo.new('GrupoDePrueba', [user1, user2], repositorio_grupos)
    repositorio_grupos.save(grupo)
    gasto = GastoEquitativo.new('gastoTest', 100, grupo)
    described_class.new.save(gasto)
    expect(gasto.id).not_to be_nil
  end
end
