require 'spec_helper'
require './email/casilla_de_correo'

RUTA_ARCHIVOS_MAIL_TEST = './tmp/testmail/'.freeze
describe CasillaCorreo do
  it 'envio de mail local' do
    casilla = described_class.new(true)
    casilla.enviar_correo('esto es una prueba', 'gbelletti@fi.uba.ar')
    archivo = File.open("#{RUTA_ARCHIVOS_MAIL_TEST}/gbelletti@fi.uba.ar")
    contenido = archivo.read
    expect(contenido.include?('esto es una prueba')).to eq true
  end
end
