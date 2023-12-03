require_relative './Field.rb'

# テトリミノの基底クラス
class Tetrimino
    attr_accessor :pos_y, :pos_x, :color, :is_landing, :is_game_over

    START_POS_X = 4
    START_POS_Y = 0

    def initialize(field)
        @field = field
        @pos_x = START_POS_X
        @pos_y = START_POS_Y
        @color = :none
        @is_landing = false
        @rotate = 0
        @fall_count_reset_value = 50
        @fall_count = @fall_count_reset_value
        @is_game_over = is_collision
    end

    # フレーム毎の更新
    def update(input)
        # 移動操作
        movement(input)
        # 落下処理
        fall(input)
    end

    # オーバーライド用ブロック取得メソッド
    def get_blocks
        blocks = Array.new(4)
        blocks[0] = [0, 0, 0, 0]
        blocks[1] = [0, 0, 0, 0]
        blocks[2] = [0, 0, 0, 0]
        blocks[3] = [0, 0, 0, 0]
        return blocks
    end

    # ゲームオーバー時に呼ばれる
    # テトリミノの色をグレーにする
    def game_over
        @color = :gray
    end

    private

    # テトリミノがフィールドのブロックに重なっているか
    def is_collision
        get_blocks.each_with_index do |sub_array, index_y|
            sub_array.each_with_index do |element, index_x|
                if element != 0 && @field.get_cell(@pos_x + index_x, @pos_y + index_y).has_block
                    return true
                end
            end
        end
        return false
    end

    # 移動操作
    def movement(input)
        case input
        when :left
            move_left_if_possible
        when :right
            move_right_if_possible
        when :rotate_left
            rotate_left_if_possible
        when :rotate_right
            rotate_right_if_possible
        end
    end

    # 落下処理
    # このメソッドが呼ばれる毎に落下カウントを1減算する
    # 落下キーが入力されたか、落下カウントが0以下になったら1セル分落下する
    # 1マス落下したら落下カウントをリセットする
    def fall(input)
        @fall_count -= 1
        if input == :down || @fall_count <= 0
            move_down_if_possible
            @fall_count = @fall_count_reset_value
        end
    end

    # 可能であれば左に移動する
    def move_left_if_possible
        @pos_x -= 1
        if is_collision
            @pos_x += 1
        end
    end

    # 可能であれば右に移動する
    def move_right_if_possible
        @pos_x += 1
        if is_collision
            @pos_x -= 1
        end
    end

    # 可能であれば左に回転する
    def rotate_left_if_possible
        @rotate -= 1
        if is_collision
            @rotate += 1
        end
    end

    # 可能であれば右に回転する
    def rotate_right_if_possible
        @rotate += 1
        if is_collision
            @rotate -= 1
        end
    end

    # 可能であれば下に落下する
    # もし着地したら着地メソッドを呼ぶ
    def move_down_if_possible
        @pos_y += 1
        if is_collision
            @pos_y -= 1
            landing
        end
    end

    # 着地
    # フィールドのテトリミノの位置のセルにブロックをセットする
    def landing
        get_blocks.each_with_index do |sub_array, index_y|
            sub_array.each_with_index do |element, index_x|
                if element != 0
                    @field.get_cell(@pos_x + index_x, @pos_y + index_y).set_block(@color)
                end
            end
        end
        @field.check_and_clear_lines
        @is_landing = true
    end
end
