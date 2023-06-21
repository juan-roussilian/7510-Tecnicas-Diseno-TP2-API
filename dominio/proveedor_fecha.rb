class ProveedorFecha
  def initialize(fecha)
    @fecha = Date.parse fecha
  end

  def es_domingo?
    @fecha.sunday?
  end
end
