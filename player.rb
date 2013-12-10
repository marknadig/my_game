require './piece'
require './intersector'
class Player < Piece
  attr_reader :bullets
  def initialize(game_window)
    super(game_window, 'images/chase.png')
    @speed =5
    @last_shot = Time.now
    restart
  end

  def move_left
    @x -= @speed if @x > 0
  end

  def move_right
    @x += @speed if @x < (@game_window.width - @width)
  end

  def move_up
    @y -= @speed if @y > 0
  end

  def move_down
    @y += @speed if @y < (@game_window.height - @height)
  end

  def hit_by?(obj)
    if Intersector.intersects(self, obj) and obj.is_a? Obstacle and !obj.destroyed
      @game_window.stop_game!
    end
  end

  def shoot
    if @bullets > 0 and (Time.now - @last_shot > 1.5)
      @last_shot = Time.now
      # unlmited @bullets -= 1
      @game_window.add_bullet(self)
    end
  end

  def restart
    @bullets = 5
    @x = 50
    @y = @game_window.height - self.height
  end

end