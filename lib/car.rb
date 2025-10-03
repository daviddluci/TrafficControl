# frozen_string_literal: true

require 'gosu'
require_relative 'constants/car_constants'

# doc
class Car
  attr_reader :type
  attr_accessor :collided

  def initialize(origin = 'N')
    @image = Gosu::Image.new('./media/car.png')
    @x, @y, @angle = CarConstants::SPAWN_POSITIONS[origin]
    @type = origin
    @collided = false
    @score = 0
  end

  def move
    dx, dy = CarConstants::MOVE_DIRECTIONS[@angle]
    @x += dx
    @y += dy
  end

  def draw
    @image.draw_rot(*image_draw_parameters)
  end

  def collides_with?(other)
    distance = Math.sqrt((@x - other.instance_variable_get(:@x))**2 +
                         (@y - other.instance_variable_get(:@y))**2)
    distance < CarConstants::COLLISION_DISTANCE
  end

  def image_draw_parameters
    [
      @x,
      @y,
      CarConstants::Z_ORDER,
      @angle,
      CarConstants::CENTER_X,
      CarConstants::CENTER_Y,
      CarConstants::SCALE_X_Y,
      CarConstants::SCALE_X_Y
    ]
  end
end
