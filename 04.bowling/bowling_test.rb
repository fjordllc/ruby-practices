require 'minitest/autorun'
require_relative './bowling'

class BowlingTest < Minitest::Test
  def test_calculate_score1
    score = "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5"
    assert_equal 139, Bowling.calculate_score(score)
  end

  def test_calculate_score2
    score = "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X"
    assert_equal 164, Bowling.calculate_score(score)
  end

  def test_calculate_score3
    score = "0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4"
    assert_equal 107, Bowling.calculate_score(score)
  end

  def test_calculate_score4
    score = "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0"
    assert_equal 134, Bowling.calculate_score(score)
  end

  def test_calculate_score5
    score = "X,X,X,X,X,X,X,X,X,X,X,X"
    assert_equal 300, Bowling.calculate_score(score)
  end
  
  def test_calculate_score6
    score = "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,0,0"
    assert_equal 114, Bowling.calculate_score(score)
  end
end
