require 'gosu'

class Snake < Gosu::Window

    def initialize
        
        super 640, 480
        self.caption = "Snake-spel"
        
        # Current-position
        @current = [0, 0]


        # Grid, odefinerade(nil) = :free
        grid = Hash.new(:free)

        # Food
        grid[[1,0]] = :food

        # Taken
        grid[[20, 20]] = :taken

        @add_x = 0
        @add_y = 0

    end


    def update

     
        time = Time.now.to_i
        
        if button_down?(Gosu::KbRight)
           
            @add_x = 30
            @add_y = 0

        end

        if button_down?(Gosu::KbDown)
            
            @add_x = 0
            @add_y = 30

        end

        if button_down?(Gosu::KbLeft)

            @add_x = -30
            @add_y = 0

        end

        if button_down?(Gosu::KbUp)
     
            @add_x = 0
            @add_y = -30


        end
        

        @current = [@current[0] + @add_x, @current[1] + @add_y]

        p @current

    end

    def draw

        #Position  x    y
        draw_rect(@current[0], @current[1], 5, 5, Gosu::Color.new(0xff_ffffff))
        
    end


end


Snake.new.show

