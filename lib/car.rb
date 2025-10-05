# frozen_string_literal: true

require 'gosu'
require_relative 'utilities'
require_relative 'constants/car_constants'
require_relative 'constants/window_constants'
require_relative 'constants/game_logic_constants'

class Car
  include CarConstants
  include Utilities

  attr_reader :type, :x, :y, :in_use, :entered_at
  attr_accessor :stopped

  def initialize(origin = 'N')
    @image = Gosu::Image.new('./media/car.png')
    @x, @y, @angle = SPAWN_POSITIONS[origin]
    @type = origin
    @stopped = false
    @in_use = false
  end

  def self.load_cars
    car_hash = Hash.new { |hash, key| hash[key] = [] }
    directions = SPAWN_POSITIONS.keys
    cars_per_direction = GameLogicConstants::MAX_CAR_COUNT / directions.size

    directions.each do |direction|
      cars_per_direction.times do
        car_hash[direction] << Car.new(direction)
      end
    end

    car_hash
  end

  def reset
    @x, @y, @angle = SPAWN_POSITIONS[type]
    @entered_at = current_time
    @stopped = false
    @in_use = true
  end

  def move
    return unless @in_use && !@stopped

    dx, dy = MOVE_DIRECTIONS[@angle]
    @x += dx * BASE_CAR_SPEED
    @y += dy * BASE_CAR_SPEED
  end

  def draw
    @image.draw_rot(*image_draw_parameters)
  end

  def update_in_use_status!
    @in_use = within_window_bounds?
  end

  def can_move?(traffic_light, car_in_front)
    return true unless traffic_light
    return false if red_light_ahead?(traffic_light)
    return false if car_in_front && car_in_front?(car_in_front)

    true
  end

  def car_in_front?(other_car)
    collides_with?(other_car.x, other_car.y, COLLISION_DISTANCE_CAR)
  end

  def collides_with_traffic_light?(traffic_light)
    collides_with?(traffic_light.positions[:x], traffic_light.positions[:y], COLLISION_DISTANCE_TRAFFIC_LIGHT)
  end

  def red_light_ahead?(traffic_light)
    traffic_light.current_state == :red && collides_with_traffic_light?(traffic_light)
  end

  def within_window_bounds?
    @x.between?(0, WindowConstants::WINDOW_WIDTH) &&
      @y.between?(0, WindowConstants::WINDOW_HEIGHT)
  end

  def image_draw_parameters
    [
      @x,
      @y,
      Z_ORDER,
      @angle,
      CENTER_X,
      CENTER_Y,
      SCALE_X_Y,
      SCALE_X_Y
    ]
  end
end
