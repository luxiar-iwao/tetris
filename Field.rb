require './Grid.rb'
require './MinoTypeI.rb'
require './MinoTypeJ.rb'
require './MinoTypeL.rb'
require './MinoTypeO.rb'
require './MinoTypeS.rb'
require './MinoTypeT.rb'
require './MinoTypeZ.rb'

class Field
    attr_reader :mino

    def initialize
        @grid = Array.new(22){ Array.new(12) }
        @updateCount = 0
        @downCount = 20
        @nextDownUpdateCount = @updateCount + @downCount
        for row in 0..21 do
            for col in 0..11 do
                if row == 0 || row == 21 || col == 0 || col == 11
                    @grid[row][col] = Grid.new(true)
                else
                    @grid[row][col] = Grid.new(false)
                end
            end
        end
        @nextMino = getMino
        @mino = getFirstMino
    end

    def update(control)
        @updateCount += 1
        
        case control
        when "left"
            moveLeft
        when "right"
            moveRight
        when "down"
            moveDown
        when "rotateLeft"
            rotateLeft
        when "rotateRight"
            rotateRight
        end

        if @updateCount >= @nextDownUpdateCount
            moveDown
        end
    end

    def getFieldColor(row, col)
        if @mino.isThere(row, col)
            @mino.color
        else
            @grid[row][col].color
        end
    end

    def getNextMinoColor(row, col)
        if @nextMino.getBlocks[row][col] != 0
            @nextMino.color
        else
            return 0
        end
    end

    def moveLeft
        @mino.posCol -= 1
        if @mino.isCollision(@grid)
            @mino.posCol += 1
        end
    end

    def moveRight
        @mino.posCol += 1
        if @mino.isCollision(@grid)
            @mino.posCol -= 1
        end
    end

    def moveDown
        @mino.posRow += 1
        if @mino.isCollision(@grid)
            @mino.posRow -= 1
            setBlock
        end
        @nextDownUpdateCount = @updateCount + @downCount
    end

    def rotateLeft
        @mino.rotate -= 1
        if @mino.isCollision(@grid)
            @mino.rotate += 1
        end
    end

    def rotateRight
        @mino.rotate += 1
        if @mino.isCollision(@grid)
            @mino.rotate -= 1
        end
    end

    def setBlock
        blocksPos = mino.getBlocksPos
        blocksPos.each do |blockPos|
            @grid[blockPos[0]][blockPos[1]].setBlock(mino.color)
        end
        @mino = getNextMino
    end

    def getMino
        case rand(7)
        when 0
            return MinoTypeI.new
        when 1
            return MinoTypeO.new
        when 2
            return MinoTypeT.new
        when 3
            return MinoTypeJ.new
        when 4
            return MinoTypeL.new
        when 5
            return MinoTypeS.new
        when 6
            return MinoTypeZ.new
        end
    end

    def getFirstMino
        case rand(5)
        when 0
            return MinoTypeI.new
        when 1
            return MinoTypeO.new
        when 2
            return MinoTypeT.new
        when 3
            return MinoTypeJ.new
        when 4
            return MinoTypeL.new
        end
    end

    def getNextMino
        @mino = @nextMino.dup
        @nextMino = getMino
    end
end
