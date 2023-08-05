require './Grid.rb'
require './Mino.rb'

class Field
    attr_reader :mino

    def initialize
        @mino = Mino.new(0)
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
        end

        if @updateCount >= @nextDownUpdateCount
            moveDown
        end
    end

    def getColor(row, col)
        if @mino.isThere(row, col)
            @mino.color
        else
            @grid[row][col].color
        end
    end

    def moveLeft
        mino.posCol -= 1
        if mino.isCollision(@grid)
            mino.posCol += 1
        end
    end

    def moveRight
        mino.posCol += 1
        if mino.isCollision(@grid)
            mino.posCol -= 1
        end
    end

    def moveDown
        mino.posRow += 1
        if mino.isCollision(@grid)
            mino.posRow -= 1
            setBlock
        end
        @nextDownUpdateCount = @updateCount + @downCount
    end

    def setBlock
        blocksPos = mino.getBlocksPos
        blocksPos.each do |blockPos|
            @grid[blockPos[0]][blockPos[1]].setBlock(mino.color)
        end
        @mino = Mino.new(0)
    end
end
