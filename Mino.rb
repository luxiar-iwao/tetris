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
            @blocks[0] = 1, 1
            @blocks[1] = 2, 1
            @blocks[2] = 1, 2
            @blocks[3] = 2, 2
            end
        end
    end

    def isThere(row, col)
        @blocks.each do |block|
            if block[0] == row - @posRow && block[1] == col - @posCol
                return true
            end
        end
        return false
    end

    def isCollision(grid)
        @blocks.each do |block|
            row = block[0] + @posRow
            col = block[1] + @posCol
            if grid[row][col].hasBlock
                return true
            end
        end
        return false
    end

    def getBlocksPos
        blocksPos = Array.new(4)
        @blocks.each_with_index do |block, i|
            blocksPos[i] = [block[0] + @posRow, block[1] + @posCol]
        end
        return blocksPos
    end
end
