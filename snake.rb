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
            Gosu::draw_rect(@pos[0], @pos[1], 25, 25, Gosu::Color.new(0xff_ff0000))
        end
    end


end

class Snake < Gosu::Window

    attr_accessor :apples


    def initialize
        
        super 525, 525
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
        @score = 0
        @gameover = false
        @text_color = 0xff_ff0000
        @apples << Food.new(self.class, [175, 300])
        @startscreen = true
    end


    def update

         @menu = Menu.new(@input)

        if Time.now - @last_moved > @delay && !@gameover && !@startscreen

            @movable = true

        end

        if Gosu.button_down?(Gosu::KB_SPACE) && @startscreen

            @text_color = 0xff_47C24E
            @startscreen = false
            
        end

        # Texts
        @start_text = Gosu::Image.from_text(self, "Spela - SPACE", Gosu.default_font_name, 40)
        @settings_text = Gosu::Image.from_text(self, "Inställningar - ENTER", Gosu.default_font_name, 40)
        @text = Gosu::Image.from_text(self, "Poäng: #{@score}", Gosu.default_font_name, 45)
        @gameover_text = Gosu::Image.from_text(self, "Gameover! Din poäng blev: #{@score}", Gosu.default_font_name, 30)

        

        @apples.each do |apple|
            if( @snake_body.last == apple.pos && !apple.eaten ) && @movable == true then
                apple.eaten = true
                @score +=1
                @delay -= 0.0002


                same_pos = true

                while same_pos
                    
                    new_x = rand(1..19) * 25 
                    new_y = rand(1..19) * 25

                    if apple.pos[0] == new_x && apple.pos[1] == new_y
                        same_pos = true
                    else
                        same_pos = false
                    end

                end

                @apples << Food.new(self.class, [new_x, new_y])


                case @current_direction
                    
        
                when :left

                    @snake_body.unshift([@snake_body[0][0] + 25, @snake_body[0][1]])

                when :up

                    @snake_body.unshift([@snake_body[0][0], @snake_body[0][1] - 25])

                when :right

                    @snake_body.unshift([@snake_body[0][0] - 25, @snake_body[0][1]])

                when :down

                    @snake_body.unshift([@snake_body[0][0], @snake_body[0][1] + 25])

                end


            end
        end

        # Check out of boundaries

        if !@snake_body.last[0].between?(0,width) || !@snake_body.last[1].between?(0,height)
                
            @gameover = true

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

                @gameover = true

            end

            @snake_body.push([@snake_body.last[0] - 25, @snake_body.last[1]])

            @last_moved = Time.now

        end

        if @current_direction == :up && @movable == true

            @snake_body.shift

            if @snake_body.include?([@snake_body.last[0], @snake_body.last[1] - 25])

                @gameover = true

            end

            @snake_body.push([@snake_body.last[0], @snake_body.last[1] - 25])

            @last_moved = Time.now

            @food_eaten = false

        end

        if @current_direction == :right && @movable == true

            @snake_body.shift

            if @snake_body.include?([@snake_body.last[0] + 25, @snake_body.last[1]])

                @gameover = true

            end

            @snake_body.push([@snake_body.last[0] + 25, @snake_body.last[1]])

            @last_moved = Time.now

        end

        if @current_direction == :down && @movable == true

            @snake_body.shift

            if @snake_body.include?([@snake_body.last[0], @snake_body.last[1] + 25])

                @gameover = true

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
            # Draw every block of the snake
            @snake_body.each do |element|
                draw_rect(element[0], element[1], 25, 25, Gosu::Color.new(0xff_ffffff))
            end

            @text.draw(10, 20, 0, 1, 1, Gosu::Color.new(0xff_808080))

            if @gameover

                @gameover_text.draw(100, 200, 0, 1, 1, Gosu::Color.new(0xff_ff0000))

            end
    
    end

end

window = Snake.new

apples = 0

until apples == 10

    window.apples << Food.new(window, [rand(1..19) * 25, rand(1..19) * 25])

    apples +=1
end

window.show