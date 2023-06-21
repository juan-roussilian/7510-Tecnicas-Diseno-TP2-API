class ProveedorClima
  MILIMTEROS_MINIMOS_LLUVIA = 0.5
  def initialize(consultor_api_clima)
    @consultor_api = consultor_api_clima
  end

  def llueve?
    @consultor_api.precipitacion_mm >= MILIMTEROS_MINIMOS_LLUVIA
  end
end
