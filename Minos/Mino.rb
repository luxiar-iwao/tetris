class Mino
    attr_accessor :posRow, :posCol, :rotate, :color

    def initialize()
        @posRow = 0
        @posCol = 4
        @rotate = 0
    end

    def isThere(row, col)
        tempRow = row - @posRow 
        tempCol = col - @posCol
        if tempRow >= 0 && tempRow <= 3 && tempCol >= 0 && tempCol <= 3
            return getBlocks[tempRow][tempCol] != 0
        else
            return false
        end
    end

    def isCollision(grid)
        for row in 0..3 do
            for col in 0..3 do
                if  getBlocks[row][col] != 0 && grid[row + @posRow][col + @posCol].hasBlock
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
                if getBlocks[row][col] != 0
                    blocksPos[count] =[row + @posRow, col + @posCol]
                    count += 1
                end
            end
        end
        return blocksPos
    end

end
