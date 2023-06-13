require_relative './abstract_repository'
class RepositorioGastos < AbstractRepository
  self.table_name = :gastos
  self.model_class = 'GastoEquitativo'

  def find_by_name(nombre)
    found_record = dataset.where(nombre:).first
    raise GastoNoEncontrado, nombre if found_record.nil?

    load_object dataset.first(found_record)
  end

  protected

  def load_object(a_hash)
    id = a_hash[:id]
    nombre = a_hash[:nombre]
    monto = a_hash[:monto]
    id_grupo = a_hash[:id]
    grupo = RepositorioGrupos.new.find(id_grupo)
    GastoEquitativo.new(nombre, monto, grupo, id:)
  end

  def changeset(gasto)
    {
      nombre: gasto.nombre,
      monto: gasto.monto,
      id_grupo: gasto.grupo.id
    }
  end
end

class GastoNoEncontrado < StandardError
  def initialize(nombre)
    @nombre = nombre
    super("Gasto con nombre #{@nombre} no encontrado")
  end
end
