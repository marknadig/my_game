require './piece'
class Badge < Piece
  def initialize(game_window)
    super(game_window, 'images/badge.png')
    restart
  end

  def restart
    @x = rand(@game_window.width - @icon.width)
    @y = 0
    @speed = rand(3..10)
    @points = 10000000
  end

  def update
    @y += @speed
    if @y > @game_window.height
      @destroyed = true
    end
  end

  def hit_by?(obj)
    # can only be hit by an bullet
    if obj.is_a? Player and Intersector.intersects(self, obj)
      @destroyed = true
      @game_window.add_points @points
    end
  end
end