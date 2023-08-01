class Mino
    def initialize
        @posX = 3
        @posY = 0
        @color = 3
        @blocks = Array.new(4){ Array.new(4) }
        @blocks[1][1] = 3
        @blocks[2][1] = 3
        @blocks[1][2] = 3
        @blocks[2][2] = 3
    end
end