require './piece'
class Thief < Piece
  def initialize(game_window)
    which = rand(1..4)
    if which < 4
      image = "thief#{which}"
      @points = 300
    else
      image = 'rex'
      @points = 1000
    end

    super(game_window, "images/#{image}.png")
    restart
  end

  def restart
    if (rand(1..2)==1) # left of right
      @x = 0
      @speed = rand(3..6)
    else
      @x = @game_window.width
      @speed = -1 * rand(3..6)
    end
    @y = rand(@game_window.width - @icon.width)
  end

  def update
    @x += @speed
    # destroy if off screen
    if @x > @game_window.width or @x < 0
      @destroyed = true
    end
  end

  def hit_by?(obj)
    # can only be hit by an player
    if obj.is_a? Player and Intersector.intersects(self, obj) and !@destroyed
      @game_window.add_points @points
      @destroyed = true
    end
  end
end