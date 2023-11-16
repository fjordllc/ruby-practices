require 'minitest/autorun'
require_relative '../lib/bowling'
require_relative '../lib/game'
require_relative '../lib/frame'
require_relative '../lib/shot'

class BowlingTest < Minitest::Test
  def test_bowling
  end

  def test_game
    game = Game.new([["6", "3"], ["9", "0"], ["0", "3"], ["8", "2"], ["7", "3"], ["X"], ["9", "1"], ["8", "0"], ["X"], ["6", "4", "5"]])
    assert_equal 94, game.sum_frames_score
    assert_equal 45, game.sum_bonus_score
    assert_equal 139, game.total_score
  end

  def test_frame
    assert_equal 12, Frame.new(['3','4','5']).sum_shots_score
    assert_equal 10, Frame.new(['X']).sum_shots_score
    assert Frame.new(['X']).strike?
    refute Frame.new(['1','9']).strike?
    assert Frame.new(['1','9']).spare?
    refute Frame.new(['X']).spare?
  end

  def test_shot
    assert_equal 2, Shot.new('2').score
    assert_equal 10, Shot.new('X').score
  end
end
