# ミノの基底クラス
class Mino
    attr_accessor :color, :isLanding, :isCanMove

    def initialize(grid)
        @posRow = 0
        @posCol = 4
        @rotate = 0
        @grid = grid
        @isLanding = false
        @isCanMove = true
        if isCollision
            @isCanMove = false
        end
    end

    # 引数の位置にミノのブロックが存在するか
    def isThere(row, col)
        tempRow = row - @posRow 
        tempCol = col - @posCol
        if tempRow >= 0 && tempRow <= 3 && tempCol >= 0 && tempCol <= 3
            return getBlocks[tempRow][tempCol] != 0
        else
            return false
        end
    end

    # ミノがフィールドのブロックに重なっているか
    def isCollision
        for row in 0..3 do
            for col in 0..3 do
                if  getBlocks[row][col] != 0 && @grid[row + @posRow][col + @posCol].hasBlock
                    return true
                end
            end
        end
        return false
    end

    # ミノのブロックが存在する座標を配列で返す
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

    # 可能であれば左に移動する
    def moveLeft
        @posCol -= 1
        if isCollision
            @posCol += 1
        end
    end

    # 可能であれば右に移動する
    def moveRight
        @posCol += 1
        if isCollision
            @posCol -= 1
        end
    end

    # 下に落下する
    # 着地したらフラグを立てる
    def moveDown
        @posRow += 1
        if isCollision
            @posRow -= 1
            @isLanding = true
        end
    end

    # 可能であれば左に回転する
    def rotateLeft
        @rotate -= 1
        if isCollision
            @rotate += 1
        end
    end

    # 可能であれば右に回転する
    def rotateRight
        @rotate += 1
        if isCollision
            @rotate -= 1
        end
    end

end
