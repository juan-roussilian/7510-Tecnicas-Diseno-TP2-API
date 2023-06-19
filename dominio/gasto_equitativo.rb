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
    @cobro = iniciacion_de_cobro
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

  def pagar(usuario, cantidad, repositorio_usuarios)
    return unless @grupo.es_miembro(usuario) # el usuario no pertenece al grupo y no puede pagar

    return if usuario_pago(usuario) == ESTADO_PAGADO # el usuario ya pago lo que debia

    if @cobro[usuario.nombre] > 0.0
      pagar_resto(usuario, cantidad, repositorio_usuarios)
    elsif cantidad < deuda_por_usuario
      pagar_fraccion(usuario, cantidad, repositorio_usuarios)
    else
      pagar_todo(usuario, repositorio_usuarios)
    end
  end

  private

  def pagar_todo(usuario, repositorio_usuarios)
    usuario.pagar(deuda_por_usuario, repositorio_usuarios)
    @cobro[usuario.nombre] = deuda_por_usuario
    deuda_por_usuario
  end

  def pagar_fraccion(usuario, cantidad, repositorio_usuarios)
    usuario.pagar(cantidad, repositorio_usuarios)
    @cobro[usuario.nombre] += cantidad
    cantidad
  end

  def pagar_resto(usuario, cantidad, repositorio_usuarios)
    if @cobro[usuario.nombre] + cantidad < deuda_por_usuario
      pagar_fraccion(usuario, cantidad, repositorio_usuarios)
    else
      cobro = deuda_por_usuario - @cobro[usuario.nombre]
      usuario.pagar(cobro, repositorio_usuarios)
      @cobro[usuario.nombre] = deuda_por_usuario
      cobro
    end
  end

  def iniciacion_de_cobro
    resultado = {}
    @grupo.usuarios.each do |usuario|
      resultado[usuario.nombre] = 0.0
    end
    resultado
  end

  def usuario_pago(usuario)
    return ESTADO_PAGADO if @cobro[usuario.nombre] == deuda_por_usuario

    ESTADO_FALTA_PAGAR
  end
end
