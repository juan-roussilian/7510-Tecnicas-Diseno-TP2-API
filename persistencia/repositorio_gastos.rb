require_relative './abstract_repository'
class RepositorioGastos < AbstractRepository
  self.table_name = :gastos
  self.model_class = 'GastoEquitativo'

  TIPO_GORRA = 'gorra'.freeze

  def find_by_name(nombre)
    found_record = dataset.where(nombre:).first
    raise GastoNoEncontrado, nombre if found_record.nil?

    load_object dataset.first(found_record)
  end

  def find_by_id(id)
    found_record = dataset.where(id:).first
    raise GastoNoEncontrado, id if found_record.nil?

    load_object dataset.first(found_record)
  end

  def find_by_creador(id_creador)
    gastos = []
    dataset.where(id_creador:).each do |gasto|
      gastos << load_object(gasto)
    end
    gastos
  end

  def find_by_grupo(id_grupo)
    gastos = []
    dataset.where(id_grupo:).each do |gasto|
      gastos << load_object(gasto)
    end
    gastos
  end

  def destroy(gasto)
    RepositorioMovimientos.new.find_by_gasto(gasto.id).each(&:delete)
    super
  end
  alias delete destroy

  def delete_all
    RepositorioMovimientos.new.find_by_tipo('pago gasto').each(&:delete)
    super
  end

  protected

  def load_object(a_hash)
    id = a_hash[:id]
    nombre = a_hash[:nombre]
    monto = a_hash[:monto]
    id_grupo = a_hash[:id_grupo]
    creador = RepositorioUsuarios.new.find(a_hash[:id_creador])
    grupo = RepositorioGrupos.new.find(id_grupo)
    if a_hash[:tipo] == TIPO_GORRA
      GastoALaGorra.new(nombre, monto, grupo, creador, id:)
    else
      GastoEquitativo.new(nombre, monto, grupo, creador, id:)
    end
  end

  def changeset(gasto)
    {
      nombre: gasto.nombre,
      monto: gasto.monto,
      id_grupo: gasto.grupo.id,
      id_creador: gasto.creador.id,
      tipo: gasto.tipo
    }
  end
end

class GastoNoEncontrado < StandardError
  def initialize(nombre)
    @nombre = nombre
    super("Gasto con nombre #{@nombre} no encontrado")
  end
end
