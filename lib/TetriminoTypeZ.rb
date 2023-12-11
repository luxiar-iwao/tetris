require_relative 'Tetrimino'

# Z字テトリミノ 緑色
class TetriminoTypeZ < Tetrimino
  def initialize(field)
    super(field)
    @color = :green
  end

  # ブロック取得メソッド
  def blocks
    case @rotate % 2
    when 0
      @blocks[0] = [0, 0, 0, 0]
      @blocks[1] = [1, 1, 0, 0]
      @blocks[2] = [0, 1, 1, 0]
      @blocks[3] = [0, 0, 0, 0]
    when 1
      @blocks[0] = [0, 0, 1, 0]
      @blocks[1] = [0, 1, 1, 0]
      @blocks[2] = [0, 1, 0, 0]
      @blocks[3] = [0, 0, 0, 0]
    end
    @blocks
  end
end
