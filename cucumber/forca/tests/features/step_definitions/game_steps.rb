#enconding: utf-8

require_relative '../../../src/forca'

Quando(/^começo um novo jogo$/) do
  forca = Forca.new
  @result = forca.start
end

Então(/^vejo a seguinte mensagem na tela:$/) do |msg|
  expect(@result).to eql msg
end