require './Minos/Mino.rb'

# L字ミノ 橙色
class MinoTypeL < Mino
    def initialize(grid)
        super(grid)
        @color = 208
    end
    
    def getBlocks
        blocks = Array.new(4)
        case @rotate % 4
        when 0
            blocks[0] = [0, 0, 0, 0]
            blocks[1] = [1, 1, 1, 0]
            blocks[2] = [1, 0, 0, 0]
            blocks[3] = [0, 0, 0, 0]
        when 1
            blocks[0] = [1, 1, 0, 0]
            blocks[1] = [0, 1, 0, 0]
            blocks[2] = [0, 1, 0, 0]
            blocks[3] = [0, 0, 0, 0]
        when 2
            blocks[0] = [0, 0, 0, 0]
            blocks[1] = [0, 0, 1, 0]
            blocks[2] = [1, 1, 1, 0]
            blocks[3] = [0, 0, 0, 0]
        when 3
            blocks[0] = [0, 1, 0, 0]
            blocks[1] = [0, 1, 0, 0]
            blocks[2] = [0, 1, 1, 0]
            blocks[3] = [0, 0, 0, 0]
        end
        return blocks
    end
end