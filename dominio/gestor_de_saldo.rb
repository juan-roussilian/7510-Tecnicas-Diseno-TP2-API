class GestorDeSaldo
  attr_reader :saldo

  def initialize(propietario)
    @propietario = propietario
    @saldo = 0
  end

  def cargar_saldo(cantidad)
    @saldo += cantidad if cantidad.positive?
    actualizar_saldo
  end

  private

  def actualizar_saldo
    RepositorioUsuarios.new.save(@propietario) unless @propietario.nil? || @propietario.id.nil?
  end
end
