require_relative './Tetrimino.rb'

# Z字テトリミノ 緑色
class TetriminoTypeZ < Tetrimino
    def initialize(field)
        super(field)
        @color = :green
    end

    def get_blocks
        blocks = Array.new(4)
        case @rotate % 2
        when 0
            blocks[0] = [0, 0, 0, 0]
            blocks[1] = [1, 1, 0, 0]
            blocks[2] = [0, 1, 1, 0]
            blocks[3] = [0, 0, 0, 0]
        when 1
            blocks[0] = [0, 0, 1, 0]
            blocks[1] = [0, 1, 1, 0]
            blocks[2] = [0, 1, 0, 0]
            blocks[3] = [0, 0, 0, 0]
        end
        return blocks
    end
end
