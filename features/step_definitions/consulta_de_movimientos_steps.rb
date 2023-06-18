def usuario_auxiliar(nombre, telegram_id)
  usuario = Usuario.new(nombre, "#{nombre}@mail.com", telegram_id, 'nombre')
  RepositorioUsuarios.new.save(usuario)
  usuario
end

def grupo_auxiliar(usuarios)
  grupo = Grupo.new('GrupoTest', usuarios)
  RepositorioGrupos.new.save(grupo)
  grupo
end

def gasto_auxiliar(usuario_creador, grupo)
  gasto = GastoEquitativo.new('gasto', 50, grupo, usuario_creador)
  RepositorioGastos.new.save(gasto)
  gasto
end

Dado('no tengo movimientos') do
  RepositorioMovimientos.new.delete_all
end

Cuando('quiero consultar mis movimientos') do
  @movimientos = JSON.parse(Faraday.get(get_url_for('/movimientos'),{ usuario: @respuesta['telegram_id'] } ).body)
end

Entonces('veo que no tengo movimientos') do
  expect(@movimientos).to eq []
end

Dado('tengo un movimiento del tipo carga saldo') do
  @carga_saldo = MovimientoCarga.new(@usuario, 50)
  RepositorioMovimientos.new.save(@carga_saldo)
end

Dado('tengo un movimiento del tipo transferencia') do
  @usuario_secundario = usuario_auxiliar('usuario1', '1')
  @transferencia = MovimientoTransferencia.new(@usuario, 50, @usuario_secundario)
  RepositorioMovimientos.new.save(@transferencia)
end 
Dado('tengo un movimiento del tipo pago de gasto')do
  @gasto = gasto_auxiliar(@usuario, grupo_auxiliar([@usuario, @usuario_secundario]))
  @pago_de_gasto = MovimientoPagoDeGasto.new(@usuario, 50, @gasto, @usuario_secundario)
  RepositorioMovimientos.new.save(@pago_de_gasto)
end
Entonces('veo que tengo un movimiento de tipo {string}') do |tipo_mov| 
  encontrado = false
  @movimientos.each do |movimiento|
    if movimiento['tipo'] == tipo_mov and (
      movimiento['id'] == @carga_saldo.id or
      movimiento['id'] == @transferencia.id or
      movimiento['id'] == @pago_de_gasto.id )
      encontrado = true 
    end
  end
  expect(encontrado).to be_true
end
