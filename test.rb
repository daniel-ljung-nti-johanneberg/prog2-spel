require "matrix"

class Snake
    attr_accessor :prev_pos, :pos
    def initialize
        @prev_pos = []
        @pos = Vector[0,0]
    end

    def update
        @prev_pos << @pos
        snake_length = 5
        @prev_pos = @prev_pos

        @pos += Vector[1, 0]
    end
end