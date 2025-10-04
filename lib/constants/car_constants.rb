# frozen_string_literal: true

module CarConstants
  COLLISION_DISTANCE_TRAFFIC_LIGHT = 45
  COLLISION_DISTANCE_CAR = 65

  Z_ORDER = 1.0
  CENTER_X = 0.5
  CENTER_Y = 0.5
  SCALE_X_Y = 0.075

  SPAWN_POSITIONS = {
    'N' => [372, 0, 0],
    'E' => [800, 292, 90],
    'S' => [428, 640, 180],
    'W' => [0, 343, 270]
  }.freeze

  MOVE_DIRECTIONS = {
    0 => [0, 1],
    90 => [-1, 0],
    180 => [0, -1],
    270 => [1, 0]
  }.freeze
end
