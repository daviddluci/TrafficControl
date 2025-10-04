# frozen_string_literal: true

require 'gosu'

module Utilities

  def collides_with?(x, y, collision_distance)
    distance = Math.sqrt((@x - x)**2 +
                         (@y - y)**2)
    distance < collision_distance
  end

  def current_time
    Gosu.milliseconds
  end
end
