# language: es
Característica: Como usuario quiero poder crear un gasto a la gorra para repartirlo con un grupo
  @local
  Escenario: 21.1 Usuario registrado en un grupo de dos personas crea un gasto equitativo y todos los miembros deben pagar hasta completar el monto
    Dado que soy un usuario registrado
    Y estoy en un grupo con "juan"
    Cuando quiero crear un gasto a la gorra de "100" con el nombre "compra"
    Entonces veo el mensaje gasto creado con id numerico
    Y debo pagar "100"
    Y "juan" debe pagar "100"

  @local
  Escenario: 21.2 Usuario registrado en un grupo de cuatro personas crea un gasto equitativo y este se divide igualmente entre los miembros
    Dado que soy un usuario registrado
    Y estoy en un grupo con "juan", "pedro" y "lucas"
    Cuando quiero crear un gasto a la gorra de "10000" con el nombre "asado"
    Entonces veo el mensaje gasto creado con id numerico
    Y debo pagar "10000"
    Y "juan" debe pagar "10000"
    Y "pedro" debe pagar "10000"
    Y "lucas" debe pagar "10000"
