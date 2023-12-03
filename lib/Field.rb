require_relative './Cell.rb'

# テトリスのフィールド
class Field
    attr_reader :grid
    MINIMUM_GRID_WIDTH = 0
    MAX_GRID_WIDTH = 11
    GRID_WIDTH_RANGE = (MINIMUM_GRID_WIDTH..MAX_GRID_WIDTH)
    MINIMUM_GRID_HEIGHT = 0
    MAX_GRID_HEIGHT = 21
    GRID_HEIGHT_RANGE = (MINIMUM_GRID_HEIGHT..MAX_GRID_HEIGHT)
    MINIMUM_GRID_INSIDE_WIDTH = 1
    MAX_GRID_INSIDE_WIDTH = 10
    GRID_INSIDE_WIDTH_RANGE = (MINIMUM_GRID_INSIDE_WIDTH..MAX_GRID_INSIDE_WIDTH)
    MINIMUM_GRID_INSIDE_HEIGHT = 1
    MAX_GRID_INSIDE_HEIGHT = 20
    GRID_INSIDE_HEIGHT_RANGE = (MINIMUM_GRID_INSIDE_HEIGHT..MAX_GRID_INSIDE_HEIGHT)

    def initialize
        @grid = Array.new
        GRID_WIDTH_RANGE.each do |x|
            GRID_HEIGHT_RANGE.each do |y|
                is_wall =
                    x == MINIMUM_GRID_WIDTH ||
                    y == MINIMUM_GRID_HEIGHT ||
                    x == MAX_GRID_WIDTH ||
                    y == MAX_GRID_HEIGHT
                @grid.push(Cell.new(x, y, is_wall))
            end
        end
    end
    
    # 指定された座標のセルを返す
    def cell(x, y)
        @grid.each do |cell|
            if cell.pos_x == x && cell.pos_y == y
                return cell
            end
        end
        return nil
    end

    # 全てのブロックをグレーにする
    def change_blocks_to_gray
        @grid.each do |cell|
            if cell.has_block
                cell.set_block(:gray)
            end
        end
    end

    # 消去可能な行を調べて消去する
    def check_and_clear_lines
        GRID_INSIDE_HEIGHT_RANGE.reverse_each do |y|
            while line_connected?(y)
                clear_line(y)
            end
        end
    end

    private

    # 指定されたy軸のcell配列を返す
    def line_cells(y)
        cells = Array.new
        @grid.each do |cell|
            if !cell.is_wall && cell.pos_y == y
                cells.push(cell)
            end
        end
        return cells
    end

    # 指定されたy軸が繋がったラインになっているかを返す
    def line_connected?(y)
        line_cells(y).each do |cell|
            if !cell.has_block
                return false
            end
        end
        return true
    end

    # 指定されたy軸のブロックを消去し、上段のブロックを1段ずつ下にずらす
    def clear_line(y)
        y.downto(MINIMUM_GRID_INSIDE_HEIGHT + 1) do |work_y|
            line_cells(work_y).each do |cell|
                cell.remove_block
                one_up_cell = cell(cell.pos_x, cell.pos_y - 1)
                if one_up_cell.has_block
                    cell.set_block(one_up_cell.color)
                end
            end
        end
    end
end
