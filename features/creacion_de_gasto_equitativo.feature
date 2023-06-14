# language: es
Característica: Como usuario quiero poder crear un gasto equitativo para repartirlo con un grupo
  @local
  Escenario: 9.1 Usuario registrado en un grupo de dos personas crea un gasto equitativo y este se divide igualmente entre los miembros
    Dado que soy un usuario registrado
    Y estoy en un grupo con "juan"
    Cuando quiero crear un gasto equitativo de "100" con el nombre "compra"
    Entonces veo el mensaje "Gasto creado" con id numerico
    Y debo pagar "50"
    Y "juan" debe pagar "50"

  @local
  Escenario: 9.2 Usuario registrado en un grupo de cuatro personas crea un gasto equitativo y este se divide igualmente entre los miembros
    Dado que soy un usuario registrado
    Y estoy en un grupo con "juan", "pedro" y "lucas"
    Cuando quiero crear un gasto equitativo de "10000" con el nombre "asado"
    Entonces veo el mensaje "Gasto creado" con id numerico
    Y debo pagar "2500"
    Y "juan" debe pagar "2500"
    Y "pedro" debe pagar "2500"
    Y "lucas" debe pagar "2500"
