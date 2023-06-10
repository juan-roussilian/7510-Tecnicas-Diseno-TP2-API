require 'integration_helper'
require_relative '../../dominio/grupo'
require_relative '../../persistencia/repositorio_grupos'
def lista_de_usuarios(cantidad)
  lista = []
  (1..cantidad).each do |i|
    RepositorioUsuarios.new.save(Usuario.new("test#{i}", "test#{i}@mail.com", i, i.to_s))
    lista.push(i.to_s)
  end
  lista
end

describe RepositorioGrupos do
  it 'deberia guardar el grupo si es nuevo' do
    grupo = Grupo.new('grupoTest', lista_de_usuarios(5), RepositorioUsuarios.new)
    described_class.new.save(grupo)
    begin
      described_class.new.find_by_name('grupoTest')
    rescue GrupoNoEncontrado
      expect(false).to eq true
    else
      expect(true).to eq true
    end
  end
  it 'guardo un grupo nuevo se incrementa la cantidad de grupos en el repositorio' do
    described_class.new.delete_all
    grupo = Grupo.new('grupoTest', lista_de_usuarios(2), RepositorioUsuarios.new)
    described_class.new.save(grupo)
    expect(described_class.new.all.size).to eq 1
  end
end
