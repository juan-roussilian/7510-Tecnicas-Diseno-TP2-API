require 'spec_helper'
require './email/casilla_de_correo'
require 'pony'

describe EMail do
  it 'envio de mail' do
    casilla = described_class.new
    casilla.enviar_correo('esto es una prueba', 'gbelletti@fi.uba.ar', test: true)
    archivo = File.open('./testmail/gbelletti@fi.uba.ar')
    contenido = archivo.read
    expect(contenido.include?('esto es una prueba')).to eq true
  end
end
