require 'gosu'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
  def initialize
    super(639, 474)
    self.caption = 'Snake Game'

    @background_image = Gosu::Image.new('media/bg.png')
    @last_update = Time.now

    foods = []
    10.times do
      x = rand(57 + 1)
      y = rand(42 + 1)
      foods << Food.new(x, y)
    end

    @snake = Snake.new(3, foods)
  end

  def update

    @snake.change_direction('left') if Gosu.button_down?(Gosu::KB_LEFT)
    @snake.change_direction('right') if Gosu.button_down?(Gosu::KB_RIGHT)
    @snake.change_direction('up') if Gosu.button_down?(Gosu::KB_UP)
    @snake.change_direction('down') if Gosu.button_down?(Gosu::KB_DOWN)


    return if (Time.now - @last_update) < 0.15

    @snake.move

    if @snake.dead?
      puts "GAME OVER"
      exit
    end

    @last_update = Time.now
  end

  def draw
    @background_image.draw(0, 0, 0)
    @snake.draw
  end
end

Game.new.show
