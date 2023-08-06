require './Display.rb'
require './PlayerInput.rb'
require './Field.rb'

# ゲーム全体の統括
class Game
    def initialize
        @display = Display.new
        @playerInput = PlayerInput.new
        @field = Field.new
    end

    def run
        loop do
            # キーボードからの入力を取得
            control = @playerInput.getControl

            # ESCキーを押されたら抜ける
            if control == "exit"
                break
            end

            # フィールドを更新
            @field.update(control)
          
            #更新後のフィールドを描画
            @display.draw(@field)

            # だいたい60FPSにするために16ms止める
            sleep(0.016)
        end

        @display.close
    end
end
