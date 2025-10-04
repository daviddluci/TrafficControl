# frozen_string_literal: true

require 'gosu'

# top level doc
class InputHandler
  def initialize(game)
    @game = game
  end

  def button_down(id)
    case id
    when Gosu::KB_LEFT
      @game.toggle_light('W')
    when Gosu::KB_RIGHT
      @game.toggle_light('E')
    when Gosu::KB_UP
      @game.toggle_light('N')
    when Gosu::KB_DOWN
      @game.toggle_light('S')
    when Gosu::KB_ESCAPE
      exit 0
    else
      puts "Unhandled key: #{id}"
    end
  end
end
