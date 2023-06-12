# language: es
Característica: Como usuario quiero poder crear grupos con otros usuarios para poder repartir gastos

  Escenario: 5.1 Usuario registrado quiere crear un grupo con una persona
    Dado que soy un usuario registrado
    Y existe un usuario con el nombre "juan"
    Cuando quiero crear un grupo con el nombre "grupo" con el usuario "juan"
    Entonces veo el mensaje "Grupo creado"
    Y el grupo "grupo" se crea

  Escenario: 5.2 Usuario registrado quiere crear un grupo con dos personas
    Dado que soy un usuario registrado
    Y existe un usuario con el nombre "juan"
    Y existe un usuario con el nombre "pedro"
    Cuando quiero crear un grupo con el nombre "amigos" con los usuarios "juan" y "pedro"
    Entonces veo el mensaje "Grupo creado"
    Y el grupo "amigos" se crea
