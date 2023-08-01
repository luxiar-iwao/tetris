require 'curses'

class Input
    
    def initialize
        Curses.noecho # キー入力をエコー表示しない
        Curses.stdscr.nodelay = 1 # getchを非ブロッキングモードにする
        Curses.curs_set(0)  # カーソルを非表示にする
    end

    def getKey
        Curses.getch
    end
end
