class Movimiento
  attr_reader :usuario, :monto
  attr_accessor :id, :updated_on, :created_on

  def initialize(usuario, monto, id: nil)
    @usuario = usuario
    @monto = monto
    @id = id
  end

  def atributos_serializables
    {
      id_usuario_principal: @usuario.id,
      monto: @monto,
      created_on: @created_on
    }
  end
end
