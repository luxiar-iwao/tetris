require_relative 'Tetrimino'

# S字テトリミノ 紫色
class TetriminoTypeS < Tetrimino
  def initialize(field)
    super(field)
    @color = :purple
  end

  # ブロック取得メソッド
  def blocks
    blocks = Array.new(4)
    case @rotate % 2
    when 0
      blocks[0] = [0, 0, 0, 0]
      blocks[1] = [0, 1, 1, 0]
      blocks[2] = [1, 1, 0, 0]
      blocks[3] = [0, 0, 0, 0]
    when 1
      blocks[0] = [1, 0, 0, 0]
      blocks[1] = [1, 1, 0, 0]
      blocks[2] = [0, 1, 0, 0]
      blocks[3] = [0, 0, 0, 0]
    end
    blocks
  end
end
