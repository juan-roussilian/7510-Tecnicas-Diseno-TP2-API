class Gasto
  attr_reader :monto, :grupo, :nombre, :creador, :updated_on, :created_on
  attr_accessor :id, :repositorio_movimientos

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

  def estado_de_usuarios
    resultado = []
    actualizar_cobros_segun_movimientos
    @grupo.usuarios.each do |usuario|
      unless usuario.telegram_id == @creador.telegram_id
        resultado.push({ nombre: usuario.nombre, estado: usuario_pago(usuario), cobro: @cobro[usuario.nombre] })
      end
    end
    resultado
  end

  private

  def iniciacion_de_cobro
    resultado = {}
    @grupo.usuarios.each do |usuario|
      resultado[usuario.nombre] = 0.0
    end
    resultado
  end
end

class UsuarioNoPerteneceAlGrupoDelGasto < StandardError
  def initialize(nombre, nombre_grupo)
    @nombre = nombre
    @nombre_grupo = nombre_grupo
    super("El usuario #{@nombre} no pertenece al grupo #{@nombre_grupo}")
  end
end
