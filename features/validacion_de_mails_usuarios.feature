# language: es
Característica: Como usuario quiero que, al intentar registrarme con un correo invalido, no se me lo permita

  @wip
  Escenario: 14.1 Usuario quiere registrarse con mail valido Dado que soy un usuario no registrado
    Dado que soy un usuario no registrado
    Cuando quiero registrarme con el mail "juan@mail.com" y el nombre "juan"
    Entonces veo que se crea correctamente el usuario

  @wip
  Escenario: 14.2 Usuario quiere registrarse con mail invalido sin dominio
    Dado que soy un usuario no registrado
    Cuando quiero registrarme con el mail "mateo.com" y el nombre "mateo"
    Entonces no se crea el usuario

  @wip
  Escenario: 14.3 Usuario quiere registrarse con mail invalido sin extension
    Dado que soy un usuario no registrado
    Cuando quiero registrarme con el mail "gabriel@" y el nombre "gabriel"
    Entonces no se crea el usuario

