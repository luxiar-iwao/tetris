require_relative './Tetrimino.rb'

# I字テトリミノ 赤色
class TetriminoTypeI < Tetrimino
    def initialize(field)
        super(field)
        @color = :red
    end

    def get_blocks
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
