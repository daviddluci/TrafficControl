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

  attr_reader :car_lines, :traffic_lights, :background, :score, :game_over, :game_over_type, :game_won

  def initialize
    @background = Gosu::Image.new(WindowConstants::WINDOW_BACKGROUND_IMAGE)
    @car_lines = Car.load_cars
    @spawn_log = CarConstants::SPAWN_POSITIONS.keys.map { |dir| [dir, 0] }.to_h
    @traffic_lights = TrafficLight.load_traffic_lights
    @score = 0
    @game_over = false
    @game_won = false
    @game_over_type = 0
  end

  def update
    return if @game_over || @game_won

    update_and_move_cars
    check_collisions
    spawn_car if should_car_be_spawned?

    @game_over ||= too_many_halted_cars?
    @game_won = @score > SCORE_TO_WIN

    update_score
  end

  def toggle_light(origin)
    @traffic_lights[origin].start_light_change
  end

  private

  def update_and_move_cars
    @car_lines.each do |origin, cars|
      light = @traffic_lights[origin]
      active_cars = cars.select(&:in_use).sort_by(&:entered_at)

      active_cars.each_with_index do |car, index|
        car_in_front = index.positive? ? active_cars[index - 1] : nil
        car.update_stopped_and_move!(light, car_in_front)
      end
    end
  end

  def too_many_halted_cars?
    @car_lines.values.any? do |line|
      line.count { |car| car.in_use && car.stopped } >= MAX_CAR_COUNT / CarConstants::SPAWN_POSITIONS.keys.size
    end
  end

  def should_car_be_spawned?
    active_car_count < MAX_CAR_COUNT && active_car_count < current_time / DELAY_BETWEEN_CAR_SPAWNS
  end

  def check_collisions
    @car_lines.values.combination(2).each do |car_line1, car_line2|
      car_line1.select(&:in_use).each do |car1|
        car_line2.select(&:in_use).each do |car2|
          next unless car1.collides_with?(car2.x, car2.y, CarConstants::COLLISION_DISTANCE_TRAFFIC_LIGHT)

          @game_over = true
          @game_over_type = 1
          return
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
