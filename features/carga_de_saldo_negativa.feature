# language: es
Característica: Como usuario al cargar saldo con valores negativos no debe modificarse mi saldo

  Escenario: 8.1 Usuario registrado quiere cargar saldo con valores negativos
    Dado que soy un usuario con saldo "100"
    Cuando quiero cargar saldo "-10"
    Entonces veo que no puedo cargar
    Y mi saldo pasa a ser "100"
