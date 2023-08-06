require './Grid.rb'
require './Minos/MinoTypeI.rb'
require './Minos/MinoTypeJ.rb'
require './Minos/MinoTypeL.rb'
require './Minos/MinoTypeO.rb'
require './Minos/MinoTypeS.rb'
require './Minos/MinoTypeT.rb'
require './Minos/MinoTypeZ.rb'

# テトリスの場
class Field
    def initialize
        @grid = Array.new(22){ Array.new(12) }
        for row in 0..21 do
            for col in 0..11 do
                if row == 0 || row == 21 || col == 0 || col == 11
                    @grid[row][col] = Grid.new(true)
                else
                    @grid[row][col] = Grid.new(false)
                end
            end
        end
        @mino = getFirstMino
        @nextMinoNumber = getRandomMinoNumber
        @nextMino = getMino(@nextMinoNumber)
        @downCountResetValue = 50
        @downCount = @downCountResetValue
        @isGameOver = false
    end

    def update(control)
        # ゲームオーバーになっていたら更新せずに抜ける
        if @isGameOver
            return
        end

        # ミノ操作
        case control
        when "left"
            @mino.moveLeft
        when "right"
            @mino.moveRight
        when "rotateLeft"
            @mino.rotateLeft
        when "rotateRight"
            @mino.rotateRight
        end

        # 落下処理
        # 更新毎に落下カウントを1減算する
        # Sキーが入力されたか、落下カウントが0以下になったら1マス落下する
        # 1マス落下したら落下カウントをリセットする
        @downCount -= 1
        if control == "down" || @downCount <= 0
            @mino.moveDown
            if @mino.isLanding
                setBlocks
            end
            @downCount = @downCountResetValue
        end
    end

    # 指定マスの色を返す
    # 操作中のミノがそのマスにある場合は、その色を返す
    def getFieldColor(row, col)
        if @mino.isThere(row, col)
            @mino.color
        else
            @grid[row][col].color
        end
    end

    # 指定次ミノマスの色を返す
    def getNextMinoColor(row, col)
        if @nextMino.getBlocks[row][col] != 0
            @nextMino.color
        else
            return 0
        end
    end

    # 操作中のミノを、その位置で固定する
    # 消去判定・次ミノへの切り替え・ゲームオーバー判定も行う
    def setBlocks
        blocksPos = @mino.getBlocksPos
        blocksPos.each do |blockPos|
            @grid[blockPos[0]][blockPos[1]].setBlock(@mino.color)
        end
        checkClearLine
        getNextMino
        if !@mino.isCanMove
            @isGameOver = true
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

    # ミノのナンバーをランダムで返す
    def getRandomMinoNumber
        rand(7)
    end

    # 引数のナンバーに対応したミノの新規インスタンスを返す
    def getMino(num)
        case num
        when 0
            return MinoTypeI.new(@grid)
        when 1
            return MinoTypeO.new(@grid)
        when 2
            return MinoTypeT.new(@grid)
        when 3
            return MinoTypeJ.new(@grid)
        when 4
            return MinoTypeL.new(@grid)
        when 5
            return MinoTypeS.new(@grid)
        when 6
            return MinoTypeZ.new(@grid)
        end
    end

    # 最初のミノは5種類のミノからランダムで選択され、その新規インスタンスを返す
    def getFirstMino
        case rand(5)
        when 0
            return MinoTypeI.new(@grid)
        when 1
            return MinoTypeO.new(@grid)
        when 2
            return MinoTypeT.new(@grid)
        when 3
            return MinoTypeJ.new(@grid)
        when 4
            return MinoTypeL.new(@grid)
        end
    end

    # 操作ミノを次ミノに切り替える
    def getNextMino
        @mino = getMino(@nextMinoNumber)
        @nextMinoNumber = getRandomMinoNumber
        @nextMino = getMino(@nextMinoNumber)
    end

    # 消去可能な行を調べて消去する
    def checkClearLine
        20.downto(1) do |row|
            while isLine(row)
                clearLine(row)
            end
        end
    end

    # 引数の行がラインになっているかを返す
    def isLine(row)
        1.upto(10) do |col|
            if !@grid[row][col].hasBlock
                return false
            end
        end
        return true
    end
    
    # 引数の行を消去し、上段の行を1行ずつ下にずらす。
    def clearLine(row)
        row.downto(2) do |workRow|
            1.upto(10) do |col|
                @grid[workRow][col].setBlock(@grid[workRow - 1][col].color)
            end
        end
    end
end
