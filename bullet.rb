require './piece'
class Bullet < Piece
  def initialize(game_window, player)
    super(game_window, 'images/bullet.png')
    @speed = 2

    # position at player
    @x = player.x
    @y = player.y
  end

  def update
    @y -= @speed
    if (@y + self.height < 0)
      @destroyed = true
    end
  end

  def hit_by?(obj)
    # can only be hit by an obstacle
    if obj.is_a? Obstacle and Intersector.intersects(self, obj)
      @destroyed = true
    end
  end

end