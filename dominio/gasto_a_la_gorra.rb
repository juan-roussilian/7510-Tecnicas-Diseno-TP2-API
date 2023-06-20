class GastoALaGorra
  attr_reader :monto, :grupo, :nombre, :creador, :updated_on, :created_on
  attr_accessor :id, :repositorio_movimientos

  TIPO_DE_GASTO = 'gorra'.freeze
  ESTADO_FALTA_PAGAR = 'Pendiente'.freeze
  ESTADO_PAGADO = 'Pagado'.freeze

  def initialize(nombre, monto, grupo, creador, id: nil)
    @nombre = nombre
    @monto = monto
    @grupo = grupo
    @creador = creador
    @id = id
    @cobro = iniciacion_de_cobro
    @total_cobrado = 0.0
    actualizar_cobros_segun_movimientos
  end

  def deuda_por_usuario
    actualizar_cobros_segun_movimientos
    falta_pagar
  end

  def deuda_pendiente_de(_usuario)
    actualizar_cobros_segun_movimientos
    falta_pagar
  end

  def tipo
    TIPO_DE_GASTO
  end

  def estado_de_usuarios
    # completar con la US de pagar gasto
    resultado = []
    actualizar_cobros_segun_movimientos
    @grupo.usuarios.each do |usuario|
      unless usuario.telegram_id == @creador.telegram_id
        resultado.push({ nombre: usuario.nombre, estado: usuario_pago(usuario), cobro: @cobro[usuario.nombre] })
      end
    end
    resultado
  end

  def pagar(usuario, cantidad, repositorio_usuarios)
    unless @grupo.es_miembro(usuario.telegram_username)
      raise UsuarioNoPerteneceAlGrupoDelGasto.new(usuario.nombre,
                                                  @grupo.nombre)
    end

    actualizar_cobros_segun_movimientos
    return 0.0 if usuario_pago(usuario) == ESTADO_PAGADO # se pago el pago

    deuda_a_pagar = determinar_deuda_a_pagar(usuario, cantidad)
    usuario.transferir(@creador, deuda_a_pagar, repositorio_usuarios, @repositorio_movimientos)
    incrementar_cobro(usuario.nombre, deuda_a_pagar)
    @repositorio_movimientos&.save(MovimientoPagoDeGasto.new(@creador, deuda_a_pagar, self,
                                                             usuario))
    deuda_a_pagar
  end

  private

  def falta_pagar
    @monto - @total_cobrado
  end

  def actualizar_cobros_segun_movimientos
    return if @repositorio_movimientos.nil?

    @grupo.usuarios.each do |usuario|
      @repositorio_movimientos.find_by_gasto(@id).each do |movimiento|
        incrementar_cobro(usuario.nombre, movimiento.monto) if movimiento.usuario_pagador.id == usuario.id
      end
    end
  end

  def incrementar_cobro(nombre, monto)
    @cobro[nombre] += monto
    @total_cobrado += monto
  end

  def determinar_deuda_a_pagar(usuario, monto_recibido)
    deuda_restante = deuda_pendiente_de(usuario)
    monto_recibido > deuda_restante ? deuda_restante : monto_recibido
  end

  def iniciacion_de_cobro
    resultado = {}
    @grupo.usuarios.each do |usuario|
      resultado[usuario.nombre] = 0.0
    end
    resultado
  end

  def usuario_pago(_usuario)
    return ESTADO_PAGADO if falta_pagar.zero?

    ESTADO_FALTA_PAGAR
  end
end
