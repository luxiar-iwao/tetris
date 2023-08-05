require './Display.rb'
require './PlayerInput.rb'
require './Field.rb'

class Game
    def initialize
        @display = Display.new
        @playerInput = PlayerInput.new
        @field = Field.new
    end

    def run
        loop do
            control = @playerInput.getControl

            if control == "exit"
                break
            end

            @field.update(control)
          
            @display.draw(@field)

            sleep(0.016) # だいたい60FPSにするために16ms止める
        end
        
        @display.close          
    end
end
