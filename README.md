TOKIO: REST API
========

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

