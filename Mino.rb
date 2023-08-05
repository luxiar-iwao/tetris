class Mino
    attr_accessor :posRow, :posCol
    attr_reader :color, :blocks

    def initialize(type)
        @posRow = 0
        @posCol = 4
        @rotate = 0
        @color = 0
        @type = type
        @blocks = Array.new(4)
        getBlocks
    end

    def getBlocks
        case @type
        when 0
            # 黄 ■
            @color = 3
            case @rotate
            when 0
            @blocks[0] = [0, 0, 0, 0]
            @blocks[1] = [0, 1, 1, 0]
            @blocks[2] = [0, 1, 1, 0]
            @blocks[3] = [0, 0, 0, 0]
            end
        end
    end

    def isThere(row, col)
        tempRow = row - @posRow 
        tempCol = col - @posCol
        if tempRow >= 0 && tempRow <= 3 && tempCol >= 0 && tempCol <= 3
            return @blocks[tempRow][tempCol] != 0
        else
            return false
        end
    end

    def isCollision(grid)
        for row in 0..3 do
            for col in 0..3 do
                if  @blocks[row][col] != 0 && grid[row + @posRow][col + @posCol].hasBlock
                    return true
                end
            end
        end
        return false
    end

    def getBlocksPos
        blocksPos = Array.new(4)
        count = 0
        for row in 0..3 do
            for col in 0..3 do
                if @blocks[row][col] != 0
                    blocksPos[count] =[row + @posRow, col + @posCol]
                    count += 1
                end
            end
        end
        return blocksPos
    end
end
