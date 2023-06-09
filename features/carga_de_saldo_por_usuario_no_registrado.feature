# language: es
Característica: Como usuario de la API quiero que esta no me permita cargar saldo para un usuario inexistente

  Escenario: 15.1 Usuario no registrado no puede cargar saldo
    Cuando quiero cargar un saldo de "500" siendo usuario no registrado
    Entonces veo que no puedo cargar
