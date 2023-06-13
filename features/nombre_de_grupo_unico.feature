# language: es
Característica: Como usuario quiero que el nombre del grupo sea único para identificarlo fácilmente

  @local
  Escenario: 6.1 Usuario registrado quiere crear un grupo con un nombre repetido
    Dado que soy un usuario registrado
    Y existe un usuario con el nombre "juancho"
    Y existe un usuario con el nombre "pedro"
    Y quiero crear un grupo con el nombre "amigo" con el usuario "juancho"
    Cuando quiero crear un grupo con el nombre "amigo" con los usuarios "juancho" y "pedro"
    Entonces veo el mensaje de error "nombre repetido no se puede llevar a cabo la operacion"
    Y no se crea el grupo
