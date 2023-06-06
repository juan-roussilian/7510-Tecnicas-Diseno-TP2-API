class GestorDeSaldo
  def cargar_saldo(saldo, cantidad)
    if cantidad.positive?
      saldo + cantidad
    else
      saldo
    end
  end

  def actualizar_saldo(usuario)
    RepositorioUsuarios.new.save(usuario) unless usuario.id.nil?
  end
end
