require 'curses'
require './Field.rb'
require './Mino.rb'

class Display

    def initialize
        Curses.init_screen 
        Curses.start_color
        Curses.use_default_colors 

        for i in 0..255 do
            Curses.init_pair(i, i, -1)
        end
        @count = 0
    end

    def draw(field)
        Curses.erase
        Curses.attron(Curses.color_pair(15))
        Curses.setpos(1, 0)
        Curses.addstr("next")

        for i in 0..3 do
            for j in 0..3 do
                color = field.getNextMinoColor(i, j)
                if color != 0
                    Curses.attron(Curses.color_pair(color))
                    Curses.setpos(i - 1, (j + 4) * 2)
                    Curses.addstr("■")
                end
            end
        end
        
        for i in 0..21 do
            for j in 0..11 do
                color = field.getFieldColor(i, j)
                if color != 0
                    Curses.attron(Curses.color_pair(color))
                    Curses.setpos(i + 2, j * 2)
                    Curses.addstr("■")
                end
            end
        end

        
        Curses.refresh
    end

    def close
        Curses.close_screen
    end
end
