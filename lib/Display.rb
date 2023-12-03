require 'curses'

# 画面描画
class Display

    SQUARE = "■"

    def initialize
        Curses.init_screen # cursesによる画面制御の開始
        Curses.start_color # カラー処理を有効化
        Curses.use_default_colors # 端末のデフォルトの前景色と背景色を使用するように設定

        # カラーペアを初期化するためのループ。cursesは256色をサポートしているので、それぞれのペアを設定します。
        for i in 0..255 do
            # 同じ前景色とデフォルトの背景色を持つカラーペアを初期化します。
            # 最初の引数はペア番号、2番目は前景色、3番目は背景色です。(-1はデフォルトの背景色を示します。)
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

    private

    # フィールドの描画
    def draw_field(field)
        field.grid.each do |cell|
            color_code = get_color_code(cell.color)
            if color_code != 0
                Curses.attron(Curses.color_pair(color_code))
                # x軸の値をそのまま使うと詰まった様な印象の画面になるので、2倍する。
                Curses.setpos(cell.pos_y, cell.pos_x * 2)
                Curses.addstr(SQUARE)
            end
        end
    end

    # テトリミノの描画
    def draw_tetrimino(tetrimino)
        color_code = get_color_code(tetrimino.color)
        Curses.attron(Curses.color_pair(color_code))
        tetrimino.get_blocks.each_with_index do |sub_array, index_y|
            sub_array.each_with_index do |element, index_x|
                if element != 0
                    # x軸の値をそのまま使うと詰まった様な印象の画面になるので、2倍する。
                    Curses.setpos(tetrimino.pos_y + index_y, (tetrimino.pos_x + index_x) * 2)
                    Curses.addstr(SQUARE)
                end
            end
        end
    end

    # 色シンボルをからカラーコードを取得する
    def get_color_code(color_symbol)
        case color_symbol
        when :red
            return 1
        when :green
            return 2
        when :yellow
            return 3
        when :blue
            return 4
        when :paleBlue
            return 6
        when :purple
            return 13
        when :brown
            return 94
        when :orange
            return 208
        when :gray
            return 240
        else
            return 0
        end
    end

    # cursesによる画面を閉じる
    def close
        Curses.close_screen
    end
end
