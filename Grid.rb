class Grid
    def initialize(color)
        @color = color
    end
    
    def setColor(color)
        @color = color
    end

    def getColor
        @color
    end

    def hasBlock
        @color != 0
    end
end