require 'rubygems'
require 'gosu'
require './player'
require './obstacle'
require './thief'
require './bullet'
require './badge'

class MyGame < Gosu::Window
  attr_reader :pieces

  def initialize
    super(500, 500, false)
    @font = Gosu::Font.new(self, "Arial", 18)
    @background =Gosu::Image.new(self, 'images/background.jpg', true)
    start_game
  end

  def update
    # escape always quites
    if button_down? Gosu::Button::KbEscape
      exit
    end

    # game stopped state
    unless @running
      if button_down? Gosu::Button::KbSpace
        start_game
      end
      return
    end

    # game running state

    if button_down? Gosu::Button::KbLeft
      @player.move_left
    end
    if button_down? Gosu::Button::KbRight
      @player.move_right
    end
    if button_down? Gosu::Button::KbUp
      @player.move_up
    end
    if button_down? Gosu::Button::KbDown
      @player.move_down
    end

    if button_down? Gosu::Button::KbSpace
      @player.shoot
    end

    add_points @pieces.count

    # Keep any pieces that are able to update
    @pieces.each { |piece|
      piece.update
      @pieces.each { |other_piece| other_piece.hit_by? piece }
    }

    # remove any pieces that have been destroyed
    @pieces.reject! { |piece| piece.destroyed}

    if (Time.now - @stopwatch) > 5
      @stopwatch = Time.now
      add_obstacle
      if (rand(1..2) ==2)
        add_thief
      end
      if rand(1..10) == 7
        add_badge
      end
    end
  end

  def draw
    @font.draw("Score <c=ffff00>#{@score}</c>", 10, 10, 1.0, 1.0, 1.0)

    #fx = self.width/@background.width
    #fy = self.height/@background.height
    #@background.draw(0,0,0, fx, fy)
    @background.draw(0,0,0)
    @pieces.each do |obstacle|
      obstacle.draw
    end
  end

  def stop_game!
    @running=false
  end

  def start_game
    @score = 0
    @stopwatch = Time.now
    @player = Player.new(self)
    @pieces = [@player]
    add_obstacle
    @running=true
  end

  def add_points(score)
    @score += score
  end

  def add_obstacle
    @pieces << Obstacle.new(self)
  end

  def add_thief
    @pieces << Thief.new(self)
  end

  def add_badge
    @pieces << Badge.new(self)
  end

  def add_bullet(player)
    @pieces << Bullet.new(self, player)
  end

end

window = MyGame.new
window.show