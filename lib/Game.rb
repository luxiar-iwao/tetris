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
        @tetrimino = get_tetrimino
    end

    def run
        loop do
            # キーボードからの入力を取得
            input = @player_input.get_input_from_key

            # ESCキーを押されたらループを抜ける
            if input == :exit
                break
            end

            # ゲームオーバーフラグの判定
            if @tetrimino.is_game_over
                @field.game_over
                @tetrimino.game_over
            else
                # テトリミノが着地していたら初期化
                if @tetrimino.is_landing
                    @tetrimino = get_tetrimino
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

    def get_tetrimino
        case rand(7)
        when 0
            return TetriminoTypeI.new(@field)
        when 1
            return TetriminoTypeO.new(@field)
        when 2
            return TetriminoTypeT.new(@field)
        when 3
            return TetriminoTypeJ.new(@field)
        when 4
            return TetriminoTypeL.new(@field)
        when 5
            return TetriminoTypeS.new(@field)
        when 6
            return TetriminoTypeZ.new(@field)
        end
    end
end
