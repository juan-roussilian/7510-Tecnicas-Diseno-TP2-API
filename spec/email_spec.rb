require 'spec_helper'
require './email/casilla_de_correo'

describe EMail do
  xit 'envio de mail' do
    casilla = described_class.new
    casilla.enviar_correo('esto es una prueba')
  end
end
