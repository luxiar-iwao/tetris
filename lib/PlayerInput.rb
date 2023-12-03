require 'curses'

# プレイヤーからの入力を取得する
class PlayerInput
    
    ESCAPE_KEY = 27 # エスケープキーが押下された場合にgetchが返す値

    def initialize
        Curses.noecho # キー入力をエコー表示しない
        Curses.stdscr.nodelay = 1 # getchを非ブロッキングモードにする
        Curses.curs_set(0)  # カーソルを非表示にする
    end

    # 入力されたキーに対応したシンボルを返す
    def get_input_from_key
        case Curses.getch
        when ESCAPE_KEY
            return :exit
        when 'a'
            return :left
        when 'd'
            return :right
        when 'w'
            return :up
        when 's'
            return :down
        when 'j'
            return :rotate_left
        when 'k'
            return :rotate_right
        else   
            return :none
        end
    end
end
