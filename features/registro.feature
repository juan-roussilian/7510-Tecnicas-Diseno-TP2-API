# language: es

Característica: Como usuario quiero poder registrarme para usar la aplicación

  Escenario: 1.1 Usuario puede registrarse con usuario y mail válido
    Dado que soy un usuario no registrado
    Cuando quiero registrarme con el mail "usuario@test.com" y el nombre "test"
    Entonces veo que se crea correctamente el usuario
    Y tiene un id único
    Y tiene "usuario@test.com" como mail
    Y tiene "test" como nombre

    #test para proxima iteracion
    @wip
  Escenario: 1.2 Usuario puede registrarse con usuario y mail válido
    Dado que soy un usuario no registrado
    Y existe un usuario con el mail "usuario@test.com"
    Cuando quiero registrarme con el mail "usuario@test.com" y el nombre "test"
    Entonces no se crea el usuario
