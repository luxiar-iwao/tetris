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
  def from_key
    case Curses.getch
    when ESCAPE_KEY
      :exit
    when 'a'
      :left
    when 'd'
      :right
    when 'w'
      :up
    when 's'
      :down
    when 'j'
      :rotate_left
    when 'k'
      :rotate_right
    else   
      :none
    end
  end
end
