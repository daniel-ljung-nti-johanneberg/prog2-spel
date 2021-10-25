require 'gosu'

class Snake < Gosu::Window

    def initialize
        @x = 200
        @y = 100
        @pressed = false

        @up = false
        @down = false
        @right = false
        @left = false

        @orentation_x = 0

        super 640, 480
        self.caption = "Snake-spel"


    end


    def update

        if button_down?(Gosu::KbRight) and !@pressed
            @pressed = true
            @right = true
        end


        @pressed = false





        if @right 

            @orentation_x += 30

        end

    end

    def draw

        #Position  x    y
        draw_rect(@orentation_x, 100, 30, 30, Gosu::Color.new(0xff_ffffff))

    end


end


Snake.new.show

