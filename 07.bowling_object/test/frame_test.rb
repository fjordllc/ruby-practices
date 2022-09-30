# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'
require_relative '../lib/shot'

class FrameTest < Minitest::Test
  def setup
    @open_frame = Frame.new(1, [5, 3])
    @strike_frame = Frame.new(1, [10])
    @spare_frame = Frame.new(1, [5, 5])
  end

  def test_number_of_pins
    assert_equal 8, @open_frame.number_of_pins

    tenth_frame = Frame.new(10, [5, 5, 9])
    assert_equal 19, tenth_frame.number_of_pins
  end

  def test_strike?
    assert @strike_frame.strike?
    refute @open_frame.strike?
  end

  def test_spare?
    assert @spare_frame.spare?
    refute @open_frame.spare?
  end

  def test_bonus_score?
    assert @strike_frame.bonus_score?
    assert @spare_frame.bonus_score?
    refute @open_frame.bonus_score?
  end
end
