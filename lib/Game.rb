require_relative './PlayerInput.rb'
require_relative './Field.rb'
require_relative './Display.rb'
require_relative './TetriminoTypeI.rb'
require_relative './TetriminoTypeO.rb'
require_relative './TetriminoTypeT.rb'
require_relative './TetriminoTypeJ.rb'
require_relative './TetriminoTypeL.rb'
require_relative './TetriminoTypeS.rb'
require_relative './TetriminoTypeZ.rb'

# ゲーム全体の統括
class Game
  def initialize
    @player_input = PlayerInput.new
    @field = Field.new
    @display = Display.new
    @tetrimino = random_tetrimino
  end

  def run
    loop do
      # キーボードからの入力を取得
      input = @player_input.from_key

      # ESCキーを押されたらループを抜ける
      if input == :exit
        break
      end

      # ゲームオーバーの判定
      if game_over?
        @field.change_blocks_to_gray
        @tetrimino.change_to_gray
      else
        # テトリミノが着地していたら初期化
        if @tetrimino.landed
          @tetrimino = random_tetrimino
        end

        # テトリミノの更新
        @tetrimino.update(input)
      end

      # 画面を描画する
      @display.draw(@field, @tetrimino)

      # だいたい60FPSにするために16ms止める
      sleep(0.016)
    end
  end

  private

  # ゲームオーバーの判定
  def game_over?
    @tetrimino.stack
  end

  # 7種類のテトリミノからランダムで選び新規オブジェクトを返す
  def random_tetrimino
    case rand(7)
    when 0
      TetriminoTypeI.new(@field)
    when 1
      TetriminoTypeO.new(@field)
    when 2
      TetriminoTypeT.new(@field)
    when 3
      TetriminoTypeJ.new(@field)
    when 4
      TetriminoTypeL.new(@field)
    when 5
      TetriminoTypeS.new(@field)
    when 6
      TetriminoTypeZ.new(@field)
    end
  end
end
