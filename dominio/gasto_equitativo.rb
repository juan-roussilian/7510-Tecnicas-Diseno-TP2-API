class GastoEquitativo
  attr_reader :monto, :grupo, :nombre, :creador, :updated_on, :created_on
  attr_accessor :id, :repositorio_movimientos

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
    actualizar_cobros_segun_movimientos
  end

  def deuda_por_usuario
    @monto / @grupo.usuarios.count
  end

  def deuda_pendiente_de(usuario)
    deuda_por_usuario - @cobro[usuario.nombre]
  end

  def tipo
    TIPO_DE_GASTO
  end

  def estado_de_usuarios
    # completar con la US de pagar gasto
    resultado = []
    actualizar_cobros_segun_movimientos
    @grupo.usuarios.each do |usuario|
      resultado.push({ nombre: usuario.nombre, estado: usuario_pago(usuario) })
    end
    resultado
  end

  def pagar(usuario, cantidad, repositorio_usuarios)
    raise UsuarioNoPerteneceAlGrupoDelGasto.new(usuario.nombre, @grupo.nombre) unless @grupo.es_miembro(usuario.nombre)

    actualizar_cobros_segun_movimientos
    return 0.0 if usuario_pago(usuario) == ESTADO_PAGADO # el usuario ya pago lo que debia

    deuda_a_pagar = determinar_deuda_a_pagar(usuario, cantidad)
    usuario.pagar(deuda_a_pagar, repositorio_usuarios)
    @cobro[usuario.nombre] += deuda_a_pagar
    @repositorio_movimientos&.save(MovimientoPagoDeGasto.new(@creador, deuda_a_pagar, self,
                                                             usuario))
    deuda_a_pagar
  end

  private

  def actualizar_cobros_segun_movimientos
    return if @repositorio_movimientos.nil?

    @grupo.usuarios.each do |usuario|
      @repositorio_movimientos.find_by_gasto(@id).each do |movimiento|
        @cobro[usuario.nombre] += movimiento.monto if movimiento.usuario_pagador.id == usuario.id
      end
    end
  end

  def determinar_deuda_a_pagar(usuario, monto_recibido)
    deuda_restante = deuda_por_usuario - @cobro[usuario.nombre]
    monto_recibido > deuda_restante ? deuda_restante : monto_recibido
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

class UsuarioNoPerteneceAlGrupoDelGasto < StandardError
  def initialize(nombre, nombre_grupo)
    @nombre = nombre
    @nombre_grupo = nombre_grupo
    super("El usuario #{@nombre} no pertenece al grupo #{@nombre_grupo}")
  end
end
