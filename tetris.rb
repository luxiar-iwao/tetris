require './Display.rb'
require './Input.rb'
require './Field.rb'
display = Display.new
input = Input.new
field = Field.new

loop do
  if input.getKey == 'q'
    break
  end
  display.draw(field)
  sleep(0.016) # だいたい60FPSにするために16ms止める
end

display.close