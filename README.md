TOKIO: REST API
========

## Integrantes
- Gabriel Belletti
- Mateo Craviotto
- Juan Cruz Roussilian

## Product Owner
- Joaquin Casal

## Detalles de la aplicación
- URL de API en ambiente de *test*: https://restapi-test-tokio-nicopaez.cloud.okteto.net/
- URL de API en ambiente de *producción*: https://restapi-prod-tokio-nicopaez.cloud.okteto.net/
- Nombre del bot en ambiente de *test*: **tokio-test-bot**
- Nombre del bot en ambiente de *producción*: **tokio-prod-bot**

Este proyecto está basado en:

* Sinatra (micro framework web) y Sequel (componente de acceso datos)
* PostgreSQL (base de datos relacional)

Por otro lado a nivel desarrollo tiene:

* Pruebas con Gherkin/Cucumber
* Pruebas con Rspec
* Medición de cobertura con SimpleCov
* Verificación de estilos con Rubocop
* Automatización de tareas de Rake

Tareas habituales
-----------------

Inicialmente hay que instalar las dependencias:

    bundle install

Luego para ejecutar test (cucumber + rspec) y linter (rubocop):

    bundle exec rake    

Finalmente para ejecutar la aplicación (ejecución de migrations y web):    

    ./start_app.sh

