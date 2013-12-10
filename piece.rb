class Piece
  attr_reader :x, :y, :height, :width, :speed, :destroyed

  def initialize(game_window, icon)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, icon, true)
    @height = @icon.height
    @width = @icon.width
  end

  def draw
    @icon.draw(@x, @y, 1)
  end

  # to be overridden by subclasses
  def hit_by?(obj)
  end

  # to be overridden by subclasses
  def update
  end

end
