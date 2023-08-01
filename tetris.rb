require './Display.rb'
require './Input.rb'
require './Field.rb'
display = Display.new
input = Input.new
field = Field.new

loop do

  key = input.getKey
  case key
  when 27 # ESC
    break
  when 'a'
    field.moveLeft
  when 'd'
    field.moveRight
  when 's'
    field.moveDown
  end

  display.draw(field)
  sleep(0.016) # だいたい60FPSにするために16ms止める
end

display.close
