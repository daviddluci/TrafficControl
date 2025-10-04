# frozen_string_literal: true

# top doc
class Renderer
  def initialize(game)
    @game = game
    @background = @game.background
    @cars = @game.car_lines
    @traffic_lights = @game.traffic_lights
  end

  def draw
    @background.draw(0, 0, 0)
    @cars.values.flatten.each do |car|
      car.draw if car.in_use
    end
    @traffic_lights.each_value(&:draw)
  end
end
