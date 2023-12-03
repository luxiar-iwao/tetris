require_relative './Field.rb'

# テトリミノの基底クラス
class Tetrimino
    attr_accessor :pos_y, :pos_x, :color, :landed, :stack

    START_POS_X = 4
    START_POS_Y = 0
    FALL_COUNT_RESET_VALUE = 50

    def initialize(field)
        @field = field
        @pos_x = START_POS_X
        @pos_y = START_POS_Y
        @color = :none
        @landed = false
        @rotate = 0
        @fall_count = FALL_COUNT_RESET_VALUE
        @stack = collision? # 初期化時に衝突していたらスタック(ゲームオーバー)フラグを立てる
    end

    # フレーム毎の更新
    def update(input)
        # 移動操作
        movement(input)
        # 落下処理
        fall(input)
    end

    # ブロック取得メソッド(派生クラスでオーバーライドされる)
    def blocks
        blocks = Array.new(4)
        blocks[0] = [0, 0, 0, 0]
        blocks[1] = [0, 0, 0, 0]
        blocks[2] = [0, 0, 0, 0]
        blocks[3] = [0, 0, 0, 0]
        return blocks
    end

    # テトリミノの色をグレーにする
    def change_to_gray
        @color = :gray
    end

    private

    # テトリミノがフィールドのブロックに重なっているか
    def collision?
        blocks.each_with_index do |sub_array, index_y|
            sub_array.each_with_index do |element, index_x|
                if element != 0 && @field.cell(@pos_x + index_x, @pos_y + index_y).has_block
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
            try_move_left
        when :right
            try_move_right
        when :rotate_left
            try_rotate_left
        when :rotate_right
            try_rotate_right
        end
    end

    # 落下処理
    # このメソッドが呼ばれる毎に落下カウントを1減算する
    # 落下キーが入力されたか、落下カウントが0以下になったら1セル分落下する
    # 落下したら落下カウントをリセットする
    def fall(input)
        @fall_count -= 1
        if input == :down || @fall_count <= 0
            try_move_down
            @fall_count = FALL_COUNT_RESET_VALUE
        end
    end

    # 可能であれば左に移動する
    def try_move_left
        @pos_x -= 1
        if collision?
            @pos_x += 1
        end
    end

    # 可能であれば右に移動する
    def try_move_right
        @pos_x += 1
        if collision?
            @pos_x -= 1
        end
    end

    # 可能であれば左に回転する
    def try_rotate_left
        @rotate -= 1
        if collision?
            @rotate += 1
        end
    end

    # 可能であれば右に回転する
    def try_rotate_right
        @rotate += 1
        if collision?
            @rotate -= 1
        end
    end

    # 可能であれば下に落下する
    # もし着地したら着地メソッドを呼ぶ
    def try_move_down
        @pos_y += 1
        if collision?
            @pos_y -= 1
            landing
        end
    end

    # 着地
    # フィールド上のテトリミノの位置のセルにブロックをセットして着地フラグを立てる
    # フィールドのライン消去メソッドを呼ぶ
    def landing
        blocks.each_with_index do |sub_array, index_y|
            sub_array.each_with_index do |element, index_x|
                if element != 0
                    @field.cell(@pos_x + index_x, @pos_y + index_y).set_block(@color)
                end
            end
        end
        @landed = true
        @field.check_and_clear_lines
    end
end
