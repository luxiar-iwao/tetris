require './Minos/Mino.rb'

# S字ミノ 紫色
class MinoTypeS < Mino
    def initialize(grid)
        super(grid)
        @color = 13
    end
    
    def getBlocks
        blocks = Array.new(4)
        case @rotate % 2
        when 0
            blocks[0] = [0, 0, 0, 0]
            blocks[1] = [0, 1, 1, 0]
            blocks[2] = [1, 1, 0, 0]
            blocks[3] = [0, 0, 0, 0]
        when 1
            blocks[0] = [1, 0, 0, 0]
            blocks[1] = [1, 1, 0, 0]
            blocks[2] = [0, 1, 0, 0]
            blocks[3] = [0, 0, 0, 0]
        end
        return blocks
    end
end