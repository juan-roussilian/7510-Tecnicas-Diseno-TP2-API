require_relative 'gasto'
class GastoEquitativo < Gasto
  TIPO_DE_GASTO = 'equitativo'.freeze

  def initialize(nombre, monto, grupo, creador, id: nil)
    super
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

  def pagar(usuario, _cantidad, repositorio_usuarios)
    unless @grupo.es_miembro(usuario.telegram_username)
      raise UsuarioNoPerteneceAlGrupoDelGasto.new(usuario.nombre,
                                                  @grupo.nombre)
    end

    actualizar_cobros_segun_movimientos
    return 0.0 if usuario_pago(usuario) == ESTADO_PAGADO # el usuario ya pago lo que debia

    deuda_a_pagar = deuda_por_usuario
    usuario.transferir(@creador, deuda_a_pagar, repositorio_usuarios, @repositorio_movimientos)
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

  def usuario_pago(usuario)
    return ESTADO_PAGADO if @cobro[usuario.nombre] == deuda_por_usuario

    ESTADO_FALTA_PAGAR
  end
end
