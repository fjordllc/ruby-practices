require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/frame'
require_relative '../lib/shot'

class GameTest < Minitest::Test
  def setup
    @marks1 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    @frames1 = [['6', '3'], ['9', '0'], ['0', '3'], ['8', '2'], ['7', '3'], ['X'], ['9', '1'], ['8', '0'], ['X'], ['6', '4', '5']]
    @game1 = Game.new(@marks1)

    @marks2 = 'X,X,X,X,X,X,X,X,X,X,X,X'
    @frames2 = [['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X', 'X', 'X']]
    @game2 = Game.new(@marks2)
  end

  def test_group_by_frame
    assert_equal @frames1, Game.group_by_frame(@marks1.split(','))
    assert_equal @frames2, Game.group_by_frame(@marks2.split(','))
  end

  def test_sum_frames_score
    assert_equal 94, @game1.sum_frames_score
    assert_equal 120, @game2.sum_frames_score
  end

  def test_sum_bonus_score
    assert_equal 45, @game1.sum_bonus_score
    assert_equal 180, @game2.sum_bonus_score
  end

  def test_total_score
    assert_equal 139, @game1.total_score
    assert_equal 300, @game2.total_score
  end
end
