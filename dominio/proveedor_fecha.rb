class ProveedorFecha
  def initialize(fecha = nil)
    @fecha = if fecha.nil?
               Date.today
             else
               Date.parse fecha
             end
  end

  def es_domingo?
    @fecha.sunday?
  end
end
