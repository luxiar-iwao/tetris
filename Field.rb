require './Grid.rb'
require './Minos/MinoTypeI.rb'
require './Minos/MinoTypeJ.rb'
require './Minos/MinoTypeL.rb'
require './Minos/MinoTypeO.rb'
require './Minos/MinoTypeS.rb'
require './Minos/MinoTypeT.rb'
require './Minos/MinoTypeZ.rb'

class Field
    attr_reader :mino

    def initialize
        @grid = Array.new(22){ Array.new(12) }
        @downCount = 30
        for row in 0..21 do
            for col in 0..11 do
                if row == 0 || row == 21 || col == 0 || col == 11
                    @grid[row][col] = Grid.new(true)
                else
                    @grid[row][col] = Grid.new(false)
                end
            end
        end
        @next = getNext
        @nextMino = getMino(@next)
        @mino = getFirstMino
        @isGameOver = false
    end

    def update(control)
        if !@isGameOver
            case control
            when "left"
                moveLeft
            when "right"
                moveRight
            when "rotateLeft"
                rotateLeft
            when "rotateRight"
                rotateRight
            end

            @downCount -= 1
            if control == "down" || @downCount <= 0
                moveDown
            end
        else
            @mino.color = 244
            for row in 1..20 do
                for col in 1..10 do
                    if @grid[row][col].hasBlock
                        @grid[row][col].setBlock(244)
                    end
                end
            end
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
        @downCount = 30
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
        blocksPos = @mino.getBlocksPos
        blocksPos.each do |blockPos|
            @grid[blockPos[0]][blockPos[1]].setBlock(mino.color)
        end
        checkClearLine
        getNextMino
        if @mino.isCollision(@grid)
            @isGameOver = true
        end
    end

    def getNext
        rand(7)
    end

    def getMino(num)
        case num
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
        @mino = getMino(@next)
        @next = getNext
        @nextMino = getMino(@next)
    end

    def checkClearLine
        20.downto(1) do |row|
            while isLine(row)
                clearLine(row)
            end
        end
    end

    def isLine(row)
        1.upto(10) do |col|
            if !@grid[row][col].hasBlock
                return false
            end
        end
        return true
    end
    
    def clearLine(row)
        row.downto(2) do |workRow|
            1.upto(10) do |col|
                @grid[workRow][col].setBlock(@grid[workRow - 1][col].color)
            end
        end
    end

end
