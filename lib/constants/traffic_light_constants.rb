# frozen_string_literal: true

module TrafficLightConstants
  MAX_BLINK_COUNT = 6
  SWITCH_DURATION = 1000
  BLINK_DURATION = 300
  Z_ORDER = 1.0
  CENTER_X = 0.5
  CENTER_Y = 0.5
  SCALE_X_Y = 0.85

  LIGHT_POSITIONS = {
    'N' => { x: 372, y: 240, angle: 90 },
    'E' => { x: 475, y: 290, angle: 0 },
    'S' => { x: 428, y: 395, angle: 90 },
    'W' => { x: 325, y: 345, angle: 0 }
  }.freeze

  IMAGES = {
    red: './media/light_red.png',
    yellow: './media/light_yellow.png',
    green: './media/light_green.png',
    stateless: './media/light_stateless.png'
  }.freeze
end
