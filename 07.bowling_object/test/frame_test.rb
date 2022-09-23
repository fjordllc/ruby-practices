# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'
require_relative '../lib/shot'

class FrameTest < Minitest::Test
  def test_number_of_pins
    frame = Frame.new(1, [5, 3])
    assert_equal 8, frame.number_of_pins

    tenth_frame = Frame.new(10, [5, 5, 9])
    assert_equal 19, tenth_frame.number_of_pins
  end
end
