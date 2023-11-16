require 'minitest/autorun'
require_relative '../lib/frame'
require_relative '../lib/shot'

class FrameTest < Minitest::Test
  def test_sum_shots_score
    assert_equal 12, Frame.new(['3','4','5']).sum_shots_score
    assert_equal 10, Frame.new(['X']).sum_shots_score
  end

  def test_strike?
    assert Frame.new(['X']).strike?
    refute Frame.new(['1','9']).strike?
  end

  def test_spare?
    assert Frame.new(['1','9']).spare?
    refute Frame.new(['X']).spare?
  end
end
