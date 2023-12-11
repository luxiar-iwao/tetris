require_relative 'Tetrimino'

# I字テトリミノ 赤色
class TetriminoTypeI < Tetrimino
  def initialize(field)
    super(field)
    @color = :red
  end

  # ブロック取得メソッド
  def blocks
    case @rotate % 2
    when 0
      @blocks[0] = [0, 0, 0, 0]
      @blocks[1] = [1, 1, 1, 1]
      @blocks[2] = [0, 0, 0, 0]
      @blocks[3] = [0, 0, 0, 0]
    when 1
      @blocks[0] = [0, 0, 1, 0]
      @blocks[1] = [0, 0, 1, 0]
      @blocks[2] = [0, 0, 1, 0]
      @blocks[3] = [0, 0, 1, 0]
    end
    @blocks
  end
end
