require_relative 'PlayerInput'
require_relative 'Field'
require_relative 'Display'
require_relative 'TetriminoTypeI'
require_relative 'TetriminoTypeO'
require_relative 'TetriminoTypeT'
require_relative 'TetriminoTypeJ'
require_relative 'TetriminoTypeL'
require_relative 'TetriminoTypeS'
require_relative 'TetriminoTypeZ'

# ゲーム全体の統括
class Game
  def initialize
    @player_input = PlayerInput.new
    @field = Field.new
    @display = Display.new
    @tetrimino = random_tetrimino
  end

  def run
    #フレームのループ
    loop do
      # キーボードからの入力を取得
      input = @player_input.from_key

      # ESCキーを押されたらループを抜ける
      if input == :exit
        break
      end

      # ゲームオーバーの判定
      if game_over?
        @field.change_all_blocks_color(:gray)
        @tetrimino.change_color(:gray)
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
    # cursesによる画面を閉じる
    @display.close
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
