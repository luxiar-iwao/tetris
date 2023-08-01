class Grid
    attr_accessor :color
    attr_reader :isWall

    def initialize(isWall)
        @isWall = isWall
        if isWall 
            @color = 94
        else
            @color = 0
        end
    end

    def setBlock(color)
        @color = color
    end

    def removeBlock()
        @color = 0
    end

    def hasBlock
        @isWall || @color != 0
    end
end
