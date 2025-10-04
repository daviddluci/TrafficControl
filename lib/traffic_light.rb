# frozen_string_literal: true

require 'gosu'
require_relative 'constants/traffic_light_constants'
require_relative 'utilities'

# doc
class TrafficLight
  include TrafficLightConstants
  include Utilities

  attr_reader :type, :current_state, :positions

  def self.load_traffic_lights
    {
      'N' => TrafficLight.new('N'),
      'S' => TrafficLight.new('S'),
      'E' => TrafficLight.new('E'),
      'W' => TrafficLight.new('W')
    }
  end

  def initialize(origin = 'N')
    @traffic_light_states_images = IMAGES.transform_values { |v| Gosu::Image.new(v) }
    @positions = LIGHT_POSITIONS[origin]
    @type = origin

    @original_state = :red
    @current_state = :red
    @should_light_change = false

    @blink_count = 0
    @last_blink_time = 0
  end

  def draw
    update_light_state if @should_light_change

    @traffic_light_states_images[@current_state].draw_rot(*image_draw_parameters)
  end

  def start_light_change
    @should_light_change = true
    @trigger_time = current_time
  end

  private
  def update_light_state
    return handle_blinking if blinking? && @original_state == :green

    @current_state = :yellow if yellow_needed?

    return unless ready_for_next_light?

    @current_state = @original_state = next_light_state
    reset_after_light_change
  end

  def handle_blinking
    return unless ready_to_blink?

    @current_state = @blink_count.odd? ? :stateless : @original_state
    @last_blink_time = current_time
    @blink_count += 1
  end

  def yellow_needed?
    @current_state != :yellow
  end

  def ready_for_next_light?
    [time_elapsed_between_light_switches, time_elapsed_between_blinks].min > SWITCH_DURATION
  end

  def next_light_state
    (@original_state == :red ? :green : :red)
  end

  def reset_after_light_change
    @should_light_change = false
    @blink_count = 0
  end

  def blinking?
    @blink_count < MAX_BLINK_COUNT
  end

  def ready_to_blink?
    time_elapsed_between_blinks > BLINK_DURATION
  end

  def image_draw_parameters
    [
      @positions[:x],
      @positions[:y],
      Z_ORDER,
      @positions[:angle],
      CENTER_X,
      CENTER_Y,
      SCALE_X_Y,
      SCALE_X_Y
    ]
  end

  def time_elapsed_between_blinks
    current_time - @last_blink_time
  end

  def time_elapsed_between_light_switches
    current_time - @trigger_time
  end
end
