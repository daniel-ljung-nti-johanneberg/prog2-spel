require 'gosu'

class Food
    attr_accessor :window, :pos, :eaten
    def initialize(window, pos_vec)

        @window = window
        @pos = pos_vec
        @eaten = false
        
    end

    def draw
        if( !@eaten ) then
            Gosu::draw_rect(@pos[0], @pos[1], 25, 25, Gosu::Color.new(0xff_029599))
        end
    end

    def mypos

        @pos

    end

    def remove_food(position)

        @pos.delete(position)

    end

end

class Snake < Gosu::Window

    attr_accessor :apples

    

    def initialize
        
        super 640, 480
        self.caption = "Snake-spel"
        
        # Current-direction
        @current_direction = :down
        # Current-positions
        @snake_body = [[25, 25], [25, 50], [25, 75], [25, 100], [25, 125], [25, 150], [25, 175], [25, 200]]
        # Last-moved
        @last_moved = Time.now
        @movable = true
        @delay = 0.1
        @apples = []
        @apples_pos = []
        @startup = true
        

    end


    def update
        if Time.now - @last_moved > @delay

            @movable = true

        end

        @apples.each do |apple|
            if( @snake_body.last == apple.pos && !apple.eaten ) then
                apple.eaten = true

                case @current_direction
                    

                when :left

                    @snake_body.push([@snake_body.last[0] - 25, @snake_body.last[1]])

                when :up

                    @snake_body.push([@snake_body.last[0], @snake_body.last[1] - 25])

                when :right

                    @snake_body.push([@snake_body.last[0] + 25, @snake_body.last[1]])

                when :down

                    @snake_body.push([@snake_body.last[0], @snake_body.last[1] + 25])

                end


            end
        end



        
        if Gosu.button_down?(Gosu::KbLeft) && @current_direction != :right
            @current_direction = :left
        end

        if Gosu.button_down?(Gosu::KbUp) && @current_direction != :down
            @current_direction = :up
        end

        if Gosu.button_down?(Gosu::KbRight) && @current_direction != :left
            @current_direction = :right
        end

        if Gosu.button_down?(Gosu::KbDown) && @current_direction != :up
            @current_direction = :down
        end

        #p @snake_body

        if @current_direction == :left && @movable

            @snake_body.shift

            if @snake_body.include?([@snake_body.last[0] - 25, @snake_body.last[1]])

                close

            end

            @snake_body.push([@snake_body.last[0] - 25, @snake_body.last[1]])

            @last_moved = Time.now

        end

        if @current_direction == :up && @movable == true

            @snake_body.shift

            if @snake_body.include?([@snake_body.last[0], @snake_body.last[1] - 25])

                close

            end

            @snake_body.push([@snake_body.last[0], @snake_body.last[1] - 25])

            @last_moved = Time.now

            @food_eaten = false

        end

        if @current_direction == :right && @movable == true

            @snake_body.shift

            if @snake_body.include?([@snake_body.last[0] + 25, @snake_body.last[1]])

                close

            end

            @snake_body.push([@snake_body.last[0] + 25, @snake_body.last[1]])

            @last_moved = Time.now

        end

        if @current_direction == :down && @movable == true

            @snake_body.shift

            if @snake_body.include?([@snake_body.last[0], @snake_body.last[1] + 25])

                close

            end

            @snake_body.push([@snake_body.last[0], @snake_body.last[1] + 25])

            @last_moved = Time.now

        end



        @movable = false

    end

    def draw
        @apples.each do |apple|
            apple.draw()
        end
        # Rita ut varje del av snaken
        @snake_body.each do |element|
            draw_rect(element[0], element[1], 25, 25, Gosu::Color.new(0xff_ffffff))
        end
    end

end



window = Snake.new

window.apples << Food.new(window, [100, 100])
window.apples << Food.new(window, [250, 100])
window.apples << Food.new(window, [300, 125])
window.apples << Food.new(window, [175, 175])
window.apples << Food.new(window, [25, 75])
window.show