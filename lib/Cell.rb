# テトリスのフィールドを構成するセル
class Cell
    attr_reader :pos_x, :pos_y, :is_wall, :has_block, :color

    def initialize(x, y, is_wall)
        @pos_x = x
        @pos_y = y
        @is_wall = is_wall
        @has_block = is_wall

        if is_wall 
            @color = :brown
        else
            @color = :none
        end
    end

    # ブロックをセットする
    def set_block(color)
        if !@is_wall
            @has_block = true
            @color = color
        end
    end

    # ブロックを消去する
    def remove_block
        if !@is_wall
            @has_block = false
            @color = :none
        end
    end
end
