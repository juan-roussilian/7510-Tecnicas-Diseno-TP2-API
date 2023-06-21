require_relative 'gasto'
class GastoALaGorra < Gasto
  TIPO_DE_GASTO = 'gorra'.freeze

  def initialize(nombre, monto, grupo, creador, id: nil)
    super
    @total_cobrado = 0.0
    actualizar_cobros_segun_movimientos
  end

  def deuda_por_usuario
    falta_pagar
  end

  def deuda_pendiente_de(_usuario)
    falta_pagar
  end

  def tipo
    TIPO_DE_GASTO
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
    return monto_recibido if monto_recibido.zero?

    monto_recibido > deuda_restante ? deuda_restante : monto_recibido
  end

  def usuario_pago(_usuario)
    return ESTADO_PAGADO if falta_pagar.zero?

    ESTADO_FALTA_PAGAR
  end
end
