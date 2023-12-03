require_relative './Tetrimino.rb'

# O字テトリミノ(スクエア) 黄色
class TetriminoTypeO < Tetrimino
    def initialize(field)
        super(field)
        @color = :yellow
    end

    def get_blocks
        blocks = Array.new(4)
        blocks[0] = [0, 0, 0, 0]
        blocks[1] = [0, 1, 1, 0]
        blocks[2] = [0, 1, 1, 0]
        blocks[3] = [0, 0, 0, 0]
        return blocks
    end
end
