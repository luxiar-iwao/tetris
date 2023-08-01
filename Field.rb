require './Grid.rb'
require './Mino.rb'

class Field
    
    def initialize()
        @grid = Array.new(22){ Array.new(12) }
        for i in 0..21 do
            for j in 0..11 do
                @grid[i][j] = Grid.new(0)
                if i == 0 || i == 21 || j == 0 || j == 11
                    @grid[i][j] = Grid.new(94)
                else
                    @grid[i][j] = Grid.new(0)
                end
            end
        end
        @mino = Mino.new
    end

    def getColor(i, j)
        @grid[i][j].getColor
    end

    def getMino(i, j)
        @mino
    end

end
