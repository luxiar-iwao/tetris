require './Mino.rb'

class MinoTypeO < Mino
    attr_reader :color, :blocks
    def initialize
        super
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