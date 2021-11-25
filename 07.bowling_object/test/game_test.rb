require 'minitest/autorun'
require '../game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new("6,3,9,1,0,3,8,2,7,3,X,3,1,8,2,X,X,4,5")
  end

  def test_total_score
    assert_equal 140, @game.total_score
  end

  def test_total_score1
    @game = Game.new("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X")
    assert_equal 164, @game.total_score
  end

  def test_total_score2
    @game = Game.new("0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4")
    assert_equal 107, @game.total_score
  end

  def test_total_score3
    @game = Game.new("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0")
    assert_equal 134, @game.total_score
  end

  def test_total_score4
    @game = Game.new("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8")
    assert_equal 144, @game.total_score
  end

  def test_total_score5
    @game = Game.new("X,X,X,X,X,X,X,X,X,X,X,X")
    assert_equal 300, @game.total_score
  end

  def test_total_score6
    @game = Game.new("0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0")
    assert_equal 0, @game.total_score
  end

  def test_total_score7
    @game = Game.new("X,X,X,X,X,X,X,X,X,0,0,0")
    assert_equal 240, @game.total_score
  end
end
