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

  def transferir(otro_usuario, cantidad)
    if transferencia_posible?(cantidad)
      @saldo = @saldo - cantidad
      otro_usuario.cargar_saldo(cantidad)
    end
  end

  private

  def actualizar_saldo
    RepositorioUsuarios.new.save(@propietario) unless @propietario.nil? || @propietario.id.nil?
  end
  def transferencia_posible?(cantidad)
    cantidad <= @saldo && cantidad.positive?
  end
end
