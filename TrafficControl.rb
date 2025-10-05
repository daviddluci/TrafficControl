# frozen_string_literal: true

require 'gosu'
require_relative 'lib/constants/window_constants'
require_relative 'lib/game_logic'
require_relative 'lib/renderer'
require_relative 'lib/input_handler'

class TrafficControl < Gosu::Window
  def initialize
    super WindowConstants::WINDOW_WIDTH, WindowConstants::WINDOW_HEIGHT

    @game = GameLogic.new
    @renderer = Renderer.new(@game)
    @input = InputHandler.new(@game)
    self.caption = 'Traffic Control'
  end

  def update
    @game.update
    self.caption = "Traffic Control | Cars in play: #{@game.car_lines.values.flatten.select(&:in_use).size} | FPS: #{Gosu.fps}"
  end

  def draw
    @renderer.draw
  end

  def button_down(id)
    @input.button_down(id)
  end
end

TrafficControl.new.show
