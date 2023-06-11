# language: es
Característica: Como usuario quiero que el nombre del grupo sea único para identificarlo fácilmente

  @wip
  Escenario: 6.1 Usuario registrado quiere crear un grupo con un nombre repetido
    Dado que soy un usuario registrado
    Y existe un usuario con el nombre "juan"
    Y existe un usuario con el nombre "pedro"
    Y hay algun grupo llamado "amigo"
    Cuando quiero crear un grupo con el nombre "amigo" con los usuarios "juan" y "pedro"
    Entonces veo el mensaje "El nombre del grupo ya esta en uso."
    Y no se crea el grupo
