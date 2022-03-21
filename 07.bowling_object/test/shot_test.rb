# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../shot'

class ShotTest < Minitest::Test
  def test_zero_score
    shot = Shot.new('0')
    assert_equal 0, shot.score
  end

  def test_base_score
    shot = Shot.new('5')
    assert_equal 5, shot.score
  end

  def test_strike_score
    shot = Shot.new('X')
    assert_equal 10, shot.score
  end
end
