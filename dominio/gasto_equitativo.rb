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
    # @cobro = cobro_por_usuario
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
    @grupo.usuarios.each do |usuario|
      resultado.push({ nombre: usuario.nombre, estado: usuario_pago(usuario) })
    end
    resultado
  end

  def pagar(usuario, cantidad); end

  private

  def usuario_pago(_usuario)
    # completar con la US de pagar gasto
    ESTADO_FALTA_PAGAR
  end

  def cobro_por_usuario
    cobro = {}
    @usuarios.each do |usuario|
      cobro[usuario.telegram_username] = 0.0
    end
    cobro
  end
end
