require 'curses'

class PlayerInput
    def initialize
        Curses.noecho # キー入力をエコー表示しない
        Curses.stdscr.nodelay = 1 # getchを非ブロッキングモードにする
        Curses.curs_set(0)  # カーソルを非表示にする
    end

    def getControl
        case getKey
        when 27 # ESC
            return "exit"
        when 'a'
            return "left"
        when 'd'
            return "right"
        when 'w'
            return "up"
        when 's'
            return "down"
        when 'j'
            return "rotateLeft"
        when 'k'
            return "rotateRight"
        else   
            return "none"
        end
    end

private
    def getKey
        Curses.getch
    end
end
