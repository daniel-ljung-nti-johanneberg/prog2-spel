require 'gosu'

class Snake < Gosu::Window

    def initialize
        
        super 640, 480
        self.caption = "Snake-spel"
        
        # Current-direction
        @current_direction = "down"
        # Current-positions
        @snake_body = [[25, 25], [25, 50], [25, 75], [25, 100]]
        # Last-moved
        @last_moved = Time.now
        @movable = true
        @delay = 0.3

    end


    def update

        if Time.now - @last_moved > @delay

            @movable = true

        end

        p Time.now - @last_moved
        
        if Gosu.button_down?(Gosu::KbLeft) && @current_direction != "right"
            @current_direction = "left"
        end

        if Gosu.button_down?(Gosu::KbUp) && @current_direction != "down"
            @current_direction = "up"
        end

        if Gosu.button_down?(Gosu::KbRight) && @current_direction != "left"
            @current_direction = "right"
        end

        if Gosu.button_down?(Gosu::KbDown) && @current_direction != 'up'
            @current_direction = "down"
        end

        p @snake_body
    
        if @current_direction == "left" && @movable == true

            @snake_body.shift

            @snake_body.push([@snake_body.last[0] - 25, @snake_body.last[1]])

            @last_moved = Time.now

        end

        if @current_direction == "up" && @movable == true

            @snake_body.shift

            @snake_body.push([@snake_body.last[0], @snake_body.last[1] - 25])

            @last_moved = Time.now

        end

        if @current_direction == "right" && @movable == true

            @snake_body.shift

            @snake_body.push([@snake_body.last[0] + 25, @snake_body.last[1]])

            @last_moved = Time.now

        end

        if @current_direction == "down" && @movable == true

            @snake_body.shift

            @snake_body.push([@snake_body.last[0], @snake_body.last[1] + 25])

            @last_moved = Time.now

        end
    
        @movable = false

    end

    def draw

        # Rita ut varje del av snaken
        @snake_body.each do |element|
            draw_rect(element[0], element[1], 25, 25, Gosu::Color.new(0xff_ffffff))
        end
    end

end


Snake.new.show

