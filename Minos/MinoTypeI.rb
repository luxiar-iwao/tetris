require './Minos/Mino.rb'

class MinoTypeI < Mino
    def initialize
        super
        @color = 1
    end
    
    def getBlocks
        blocks = Array.new(4)
        case @rotate % 2
        when 0
            blocks[0] = [0, 0, 0, 0]
            blocks[1] = [1, 1, 1, 1]
            blocks[2] = [0, 0, 0, 0]
            blocks[3] = [0, 0, 0, 0]
        when 1
            blocks[0] = [0, 0, 1, 0]
            blocks[1] = [0, 0, 1, 0]
            blocks[2] = [0, 0, 1, 0]
            blocks[3] = [0, 0, 1, 0]
        end
        return blocks
    end

end