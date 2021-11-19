require 'minitest/autorun'
require '../shot'

class ShotTest < Minitest::Test
  def test_shot_score
    @shot = Shot.new("0")
    assert_equal 0, @shot.score
  end

  def test_shot_score1
    @shot = Shot.new("X")
    assert_equal 10, @shot.score
  end

  def test_shot_score2
    @shot = Shot.new("5")
    assert_equal 5, @shot.score
  end
end
