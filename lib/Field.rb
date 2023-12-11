require_relative 'Cell'

# テトリスのフィールド
class Field
  attr_reader :grid

  # グリッド全体の幅と高さ
  MINIMUM_GRID_WIDTH = 0
  MAX_GRID_WIDTH = 11
  GRID_WIDTH_RANGE = (MINIMUM_GRID_WIDTH..MAX_GRID_WIDTH)
  MINIMUM_GRID_HEIGHT = 0
  MAX_GRID_HEIGHT = 21
  GRID_HEIGHT_RANGE = (MINIMUM_GRID_HEIGHT..MAX_GRID_HEIGHT)

  # グリッド内側の幅と高さ
  MINIMUM_GRID_INSIDE_WIDTH = 1
  MAX_GRID_INSIDE_WIDTH = 10
  GRID_INSIDE_WIDTH_RANGE = (MINIMUM_GRID_INSIDE_WIDTH..MAX_GRID_INSIDE_WIDTH)
  MINIMUM_GRID_INSIDE_HEIGHT = 1
  MAX_GRID_INSIDE_HEIGHT = 20
  GRID_INSIDE_HEIGHT_RANGE = (MINIMUM_GRID_INSIDE_HEIGHT..MAX_GRID_INSIDE_HEIGHT)

  def initialize
    # フィールドを構成するグリッドを作成する
    @grid = Array.new
    GRID_WIDTH_RANGE.each do |x|
      GRID_HEIGHT_RANGE.each do |y|
        # グリッドの端は壁にする
        is_wall =
          x == MINIMUM_GRID_WIDTH ||
          y == MINIMUM_GRID_HEIGHT ||
          x == MAX_GRID_WIDTH ||
          y == MAX_GRID_HEIGHT
        # グリッドにセルを追加する
        @grid.push(Cell.new(x, y, is_wall))
      end
    end
  end
  
  # 指定された座標のセルを返す
  # 指定された座標のセルが無い場合はnilを返す
  def cell_at(x, y)
    @grid.each do |cell|
      if cell.pos_x == x && cell.pos_y == y
        return cell
      end
    end
    nil
  end

  # 消去可能な行を調べて消去する
  def check_and_clear_lines
    # 最下段から最上段までのループ
    GRID_INSIDE_HEIGHT_RANGE.reverse_each do |y|
      # チェック対象のy軸が繋がったラインになっているかを調べて、なっていれば消去する
      # 消した後に上段のブロックを1段ずつ下にずらすので、
      # ずらし後に繋がったラインが来なくなるまでwhile文で繰り返す
      while line_connected?(y)
        clear_line(y)
      end
    end
  end

  # フィールド上の全てのブロックの色を変更する
  def change_all_blocks_color(color)
    @grid.each do |cell|
      if cell.has_block
        cell.set_block(color)
      end
    end
  end

  private

  # 指定されたy軸のcell配列を返す(壁を除く)
  def line_cells(y)
    cells = Array.new
    @grid.each do |cell|
      if !cell.is_wall && cell.pos_y == y
        cells.push(cell)
      end
    end
    cells
  end

  # 指定されたy軸が繋がったラインになっているかを返す
  def line_connected?(y)
    line_cells(y).each do |cell|
      if !cell.has_block
        return false
      end
    end
    true
  end

  # 指定されたy軸のブロックを消去し、上段のブロックを1段ずつ下にずらす
  def clear_line(y)
    # 指定されたy軸から最上段までのループ
    y.downto(MINIMUM_GRID_INSIDE_HEIGHT) do |work_y|
      # work_y軸のセル毎のループ
      line_cells(work_y).each do |cell|
        # セルのブロックを消去する
        cell.remove_block
        # 1段上のセルを取得する
        one_up_cell = cell_at(cell.pos_x, cell.pos_y - 1)
        # 1段上のセルにブロックがあれば、
        # そのブロックをセルに移動する
        if !one_up_cell.is_wall && one_up_cell.has_block
          cell.set_block(one_up_cell.color)
        end
      end
    end
  end
end
