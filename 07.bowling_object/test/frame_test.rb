# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../frame'

class FrameTest < Minitest::Test
  def test_base_score
    frame = Frame.new('2', '5', '0')
    assert_equal 7, frame.score
  end

  def test_strike_score
    frame = Frame.new('X', '3', '5')
    assert_equal 18, frame.score
  end

  def test_spare_score
    frame = Frame.new('7', '3', '5')
    assert_equal 15, frame.score
  end
end
