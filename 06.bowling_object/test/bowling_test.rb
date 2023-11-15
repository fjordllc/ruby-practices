require 'minitest/autorun'
require_relative '../lib/bowling'
require_relative '../lib/game'
require_relative '../lib/frame'
require_relative '../lib/shot'

class BowlingTest < Minitest::Test

  def test_frame
    assert Frame.new(['1','2'])
    assert_equal 12, Frame.new(['3','4','5']).sum_shots_score
    assert_equal 10, Frame.new(['X']).sum_shots_score
  end

  def test_shot
    assert Shot.new('1')
    assert_equal 2, Shot.new('2').score
    assert_equal 10, Shot.new('X').score
  end
end
