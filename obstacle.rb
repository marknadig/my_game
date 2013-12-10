require './piece'
class Obstacle < Piece
  def initialize(game_window)
    super(game_window, 'images/obstacle.png')
    restart
  end

  def restart
    @x = rand(@game_window.width - @icon.width)
    @y = 0
    @speed = rand(3..10)
  end

  def update
    @y += @speed
    if @y > @game_window.height
      restart
    end
  end

  def hit_by?(obj)
    # can only be hit by an bullet
    if obj.is_a? Bullet and Intersector.intersects(self, obj)
      @destroyed = true
    end
  end
end