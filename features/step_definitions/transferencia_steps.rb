Cuando('quiero transferir {float} al usuario registrado {string} con saldo {float}') do |saldo, nombre, saldo_o|
  @usuario_transferencia = RepositorioUsuarios.new.find_by_name(nombre)
  @usuario_transferencia.cargar_saldo(saldo_o)
  @usuario.transferir(saldo, @usuario_transferencia)
end

Cuando('el saldo de {string} es {int}') do |mail, saldo|
  @usuario_transferencia = RepositorioUsuarios.new.find_by_mail(mail)
  @usuario_transferencia.cargar_saldo(saldo_o)
  expect(@usuario_transferencia.saldo).to eq saldo
end
