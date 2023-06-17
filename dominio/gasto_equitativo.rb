class GastoEquitativo
  attr_reader :monto, :grupo, :nombre, :creador, :updated_on, :created_on
  attr_accessor :id

  TIPO_DE_GASTO = 'equitativo'.freeze
  ESTADO_FALTA_PAGAR = 'Pendiente'.freeze
  ESTADO_PAGADO = 'Pagado'.freeze

  def initialize(nombre, monto, grupo, creador, id: nil)
    @nombre = nombre
    @monto = monto
    @grupo = grupo
    @creador = creador
    @id = id
  end

  def deuda_por_usuario
    @monto / @grupo.usuarios.count
  end

  def tipo
    TIPO_DE_GASTO
  end

  def estado_de_usuarios
    # completar con la US de pagar gasto
    resultado = []
    @grupo.usuarios.each.each do |usuario|
      resultado.push({ nombre: usuario.nombre, estado: usuario_pago(usuario) })
    end
    resultado
  end

  def usuario_pago(_usuario)
    # completar con la US de pagar gasto
    ESTADO_FALTA_PAGAR
  end
end
