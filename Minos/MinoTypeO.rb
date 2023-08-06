require './Minos/Mino.rb'

# O字ミノ(スクエア) 黄色
class MinoTypeO < Mino
    def initialize(grid)
        super(grid)
        @color = 3
    end
    def getBlocks
        blocks = Array.new(4)
        blocks[0] = [0, 0, 0, 0]
        blocks[1] = [0, 1, 1, 0]
        blocks[2] = [0, 1, 1, 0]
        blocks[3] = [0, 0, 0, 0]
        return blocks
    end

end