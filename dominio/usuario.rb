class Usuario
  attr_reader :nombre, :email, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, email, id = nil)
    @nombre = nombre
    @email = email
    @id = id
  end
end
