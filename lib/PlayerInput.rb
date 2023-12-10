require 'curses'

# プレイヤーからの入力を取得する
class PlayerInput
  
  # エスケープキーが押下された場合にCurses.getchが返す値
  ESCAPE_KEY = 27

  def initialize
    # キー入力をエコー表示しない
    Curses.noecho
    # getchを非ブロッキングモードにする
    Curses.stdscr.nodelay = 1
    # カーソルを非表示にする
    Curses.curs_set(0)
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
