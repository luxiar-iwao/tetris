require_relative './Cell.rb'

# テトリスのフィールド
class Field
    attr_reader :grid
    MINIMUM_GRID_WIDTH = 0
    MINIMUM_GRID_HEIGHT = 0
    MAX_GRID_WIDTH = 11
    MAX_GRID_HEIGHT = 21
    MINIMUM_GRID_INSIDE_WIDTH = 1
    MINIMUM_GRID_INSIDE_HEIGHT = 1
    MAX_GRID_INSIDE_WIDTH = 10
    MAX_GRID_INSIDE_HEIGHT = 20

    def initialize
        @grid = Array.new
        (MINIMUM_GRID_WIDTH..MAX_GRID_WIDTH).each do |x|
            (MINIMUM_GRID_HEIGHT..MAX_GRID_HEIGHT).each do |y|
                is_wall = x == MINIMUM_GRID_WIDTH || y == MINIMUM_GRID_HEIGHT || x == MAX_GRID_WIDTH || y == MAX_GRID_HEIGHT 
                @grid.push(Cell.new(x, y, is_wall))
            end
        end
    end
    
    # 指定された座標のセルを返す
    def get_cell(x, y)
        @grid.each do |cell|
            if cell.pos_x == x && cell.pos_y == y
                return cell
            end
        end
        return nil
    end

    # 消去可能な行を調べて消去する
    def check_and_clear_lines
        MAX_GRID_INSIDE_HEIGHT.downto(MINIMUM_GRID_INSIDE_HEIGHT) do |y|
            while is_line(y)
                clear_line(y)
            end
        end
    end

    # ゲームオーバー時に呼ばれる
    # 全てのブロックをグレーにする
    def game_over
        (MINIMUM_GRID_INSIDE_WIDTH..MAX_GRID_INSIDE_WIDTH).each do |x|
            (MINIMUM_GRID_INSIDE_HEIGHT..MAX_GRID_INSIDE_HEIGHT).each do |y|
                cell = get_cell(x, y)
                if cell.has_block
                    cell.set_block(:gray)
                end
            end
        end
    end

    private

    # 引数の行がラインになっているかを返す
    def is_line(y)
        MINIMUM_GRID_INSIDE_WIDTH.upto(MAX_GRID_INSIDE_WIDTH) do |x|
            if !get_cell(x, y).has_block
                return false
            end
        end
        return true
    end

    # 引数の行を消去し、上段の行を1行ずつ下にずらす
    def clear_line(y)
        y.downto(MINIMUM_GRID_INSIDE_HEIGHT + 1) do |work_y|
            MINIMUM_GRID_INSIDE_WIDTH.upto(MAX_GRID_INSIDE_WIDTH) do |x|
                cell = get_cell(x, work_y)
                one_up_cell = get_cell(x, work_y - 1)
                cell.remove_block
                if one_up_cell.has_block
                    cell.set_block(one_up_cell.color)
                end
            end
        end
    end
end
