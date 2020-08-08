class Snake
  MAX_X = 57
  MAX_Y = 42

  def initialize(size, foods)
    @cube = Gosu::Image.new('media/green_cube.png')
    @direction = 'right'
    @segments = [{ x: 28, y: 21 }]
    size.times { self.grow }
    @foods = foods
  end

  def move
    case @direction
    when 'up' then    @segments.unshift({ x: @segments.first[:x], y: @segments.first[:y] - 1 })
    when 'down' then  @segments.unshift({ x: @segments.first[:x], y: @segments.first[:y] + 1 })
    when 'left' then  @segments.unshift({ x: @segments.first[:x] - 1, y: @segments.first[:y] })
    when 'right' then @segments.unshift({ x: @segments.first[:x] + 1, y: @segments.first[:y] })
    end
    @segments.pop

    @foods.each do |food|
      if @segments.first[:x] == food.x && @segments.first[:y] == food.y
        3.times { self.grow }
        food.eat!
      end
    end

  end

  def grow
    @segments << @segments.last.dup
  end

  def dead?
    return true if @segments.first[:x] < 0 || @segments.first[:x] > MAX_X || @segments.first[:y] < 0 || @segments.first[:y] > MAX_Y

    @segments.each_with_index do |segment, index|
      next if index.zero?

      head = @segments.first
      # puts "head_x: #{head[:x]} head_y: #{head[:y]} segment_x: #{segment[:x]} segment_y: #{segment[:y]}"
      return true if head[:x] == segment[:x] && head[:y] == segment[:y]
    end

    return false
  end


  def draw
    @segments.each do |segment|
      @cube.draw((segment[:x] * 11) + 1, (segment[:y] * 11) + 1, 1)
    end

    @foods.each{ |food| food.draw }
  end

  def change_direction(new_direction)
    return if (@direction == 'up' && new_direction == 'down') ||
              (@direction == 'down' && new_direction == 'up') ||
              (@direction == 'left' && new_direction == 'right') ||
              (@direction == 'right' && new_direction == 'left')

    @direction = new_direction
  end
end
