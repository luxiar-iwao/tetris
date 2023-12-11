require_relative 'Tetrimino'

# L字テトリミノ 橙色
class TetriminoTypeL < Tetrimino
  def initialize(field)
    super(field)
    @color = :orange
  end

  # ブロック取得メソッド
  def blocks
    blocks = Array.new(4)
    case @rotate % 4
    when 0
      blocks[0] = [0, 0, 0, 0]
      blocks[1] = [1, 1, 1, 0]
      blocks[2] = [1, 0, 0, 0]
      blocks[3] = [0, 0, 0, 0]
    when 1
      blocks[0] = [1, 1, 0, 0]
      blocks[1] = [0, 1, 0, 0]
      blocks[2] = [0, 1, 0, 0]
      blocks[3] = [0, 0, 0, 0]
    when 2
      blocks[0] = [0, 0, 0, 0]
      blocks[1] = [0, 0, 1, 0]
      blocks[2] = [1, 1, 1, 0]
      blocks[3] = [0, 0, 0, 0]
    when 3
      blocks[0] = [0, 1, 0, 0]
      blocks[1] = [0, 1, 0, 0]
      blocks[2] = [0, 1, 1, 0]
      blocks[3] = [0, 0, 0, 0]
    end
    blocks
  end
end
