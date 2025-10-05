class Renderer
  def initialize(game)
    @game = game
    @background = @game.background
    @cars = @game.car_lines
    @traffic_lights = @game.traffic_lights
    @font = Gosu::Font.new(30)
  end

  def draw
    @background.draw(0, 0, 0)
    @cars.values.flatten.each { |car| car.draw if car.in_use }
    @traffic_lights.each_value(&:draw)
    draw_ui
  end

  private

  def draw_ui
    draw_text("Score: #{@game.score}", 20, 20, Gosu::Color::BLACK)
    draw_text('EXIT - ESC', 20, 600, Gosu::Color::YELLOW)
    draw_game_over if @game.game_over
    draw_game_won if @game.game_won
  end

  def draw_game_over
    draw_text('GAMEOVER', 600, 20, Gosu::Color::RED)
    message = @game.game_over_type == 1 ? 'COLLISION' : 'TRAFFIC JAM'
    draw_text(message, 600, 50, Gosu::Color::RED)
  end

  def draw_game_won
    draw_text('GAME WON!', 320, 300, Gosu::Color::GREEN)
  end

  def draw_text(text, x, y, color, z = 3, scale_x = 1.0, scale_y = 1.0)
    @font.draw_text(text, x, y, z, scale_x, scale_y, color)
  end
end
