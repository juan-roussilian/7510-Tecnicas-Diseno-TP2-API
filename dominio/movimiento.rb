class Movimiento
  attr_reader :usuario, :monto, :updated_on, :created_on
  attr_accessor :id

  def initialize(usuario, monto, id: nil)
    @usuario = usuario
    @monto = monto
    @id = id
  end

  def atributos_serializables
    {
      id_usuario_principal: @usuario.id,
      monto: @monto
    }
  end
end
