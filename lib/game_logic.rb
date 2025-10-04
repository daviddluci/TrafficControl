# frozen_string_literal: true

require_relative 'car'
require_relative 'traffic_light'
require_relative 'utilities'
require_relative 'constants/window_constants'
require_relative 'constants/car_constants'
require_relative 'constants/game_logic_constants'

class GameLogic
  include GameLogicConstants
  include Utilities

  attr_reader :car_lines, :traffic_lights, :background, :game_over

  def initialize
    @background = Gosu::Image.new(WindowConstants::WINDOW_BACKGROUND_IMAGE)
    @car_lines = Car.load_cars
    @spawn_log = CarConstants::SPAWN_POSITIONS.keys.map { |dir| [dir, 0] }.to_h
    @traffic_lights = TrafficLight.load_traffic_lights
    @game_over = false
  end

  def update
    return if @game_over

    update_and_move_cars
    check_collisions
    spawn_car if should_car_be_spawned?
  end

  def toggle_light(origin)
    @traffic_lights[origin].start_light_change
  end

  private

  def update_and_move_cars
    @car_lines.each do |origin, cars|
      light = @traffic_lights[origin]
      active_cars = cars.select(&:in_use)

      active_cars.each_with_index do |car, index|

        car_in_front = index.positive? ? active_cars[index - 1] : nil
        car.stopped = !car.can_move?(light, car_in_front)
        car.move unless car.stopped
        car.update_in_use_status!
      end
    end
  end

  def should_car_be_spawned?
    active_car_count < MAX_CAR_COUNT && active_car_count < current_time / DELAY_BETWEEN_CAR_SPAWNS
  end

  def check_collisions
    @car_lines.values.combination(2).each do |car_line1, car_line2|

      car_line1.select(&:in_use).each do |car1|
        car_line2.select(&:in_use).each do |car2|
          if car1.collides_with?(car2.x, car2.y, CarConstants::COLLISION_DISTANCE_TRAFFIC_LIGHT)
            @game_over = true
            puts 'collision'
          end
        end
      end
    end
  end

  def spawn_car
    dir = CarConstants::SPAWN_POSITIONS.keys.sample
    car = @car_lines[dir].find { |c| !c.in_use }
    return if car.nil? || current_time - @spawn_log[car.type] < DELAY_BETWEEN_CAR_SPAWNS

    @spawn_log[car.type] = current_time
    car.reset
  end

  def active_car_count
    @car_lines.values.flatten.count(&:in_use)
  end
end
