require 'curses'

# 画面描画
class Display

  SQUARE = '■'

  def initialize
    # cursesによる画面制御の開始
    Curses.init_screen
    # カラー処理を有効化
    Curses.start_color
    # 端末のデフォルトの前景色と背景色を使用するように設定
    Curses.use_default_colors

    # カラーペアを初期化するためのループ
    # cursesは256色をサポートしているので、それぞれのペアを設定する
    for i in 0..255 do
      # 同じ前景色とデフォルトの背景色を持つカラーペアを初期化する
      # 引数:1番目はペア番号、2番目は前景色、3番目は背景色(-1はデフォルトの背景色)
      Curses.init_pair(i, i, -1)
    end
  end

  # フィールドとテトリミノの情報をもとに画面を描画する
  def draw(field, tetrimino)
    # 画面をクリア
    Curses.erase
    # フィールドの描画
    draw_field(field)
    # テトリミノの描画
    draw_tetrimino(tetrimino)
    # 画面に変更を反映
    Curses.refresh
  end

  # cursesによる画面を閉じる
  def close
    Curses.close_screen
  end

  private

  # フィールドの描画
  def draw_field(field)
    field.grid.each do |cell|
      # カラーペア番号を取得する
      color_number = symbol_to_color_number(cell.color)
      if color_number != 0
        # カラーペアを適用する
        Curses.attron(Curses.color_pair(color_number))
        # カーソル位置を設定する
        # x軸の値をそのまま使うと詰まった様な印象の画面になるので2倍する
        Curses.setpos(cell.pos_y, cell.pos_x * 2)
        # ブロックを描画する
        Curses.addstr(SQUARE)
      end
    end
  end

  # テトリミノの描画
  def draw_tetrimino(tetrimino)
    # カラーペア番号を取得する
    color_number = symbol_to_color_number(tetrimino.color)
    # カラーペアを適用する
    Curses.attron(Curses.color_pair(color_number))
    # テトリミノのブロックを描画する多重ル多重ループ
    tetrimino.blocks.each_with_index do |sub_array, index_y|
      sub_array.each_with_index do |element, index_x|
        if element != 0
          # カーソル位置を設定する
          # x軸の値をそのまま使うと詰まった様な印象の画面になるので2倍する
          Curses.setpos(tetrimino.pos_y + index_y, (tetrimino.pos_x + index_x) * 2)
          # ブロックを描画する
          Curses.addstr(SQUARE)
        end
      end
    end
  end

  # 色シンボルからカラーペア番号を取得する
  def symbol_to_color_number(color_symbol)
    case color_symbol
    when :red
      1
    when :green
      2
    when :yellow
      3
    when :blue
      4
    when :paleBlue
      6
    when :purple
      13
    when :brown
      94
    when :orange
      208
    when :gray
      240
    else
      0
    end
  end
end
