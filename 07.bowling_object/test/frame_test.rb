require 'minitest/autorun'
require '../frame'

class FrameTest < Minitest::Test
  def test_frame_score
    @frame = Frame.new("X")
    assert_equal 10, @frame.score
  end

  def test_frame_score1
    @frame = Frame.new("1","9")
    assert_equal 10, @frame.score
  end

  def test_frame_score2
    @frame = Frame.new("3","5")
    assert_equal 8, @frame.score
  end

  def test_frame_score3
    @frame = Frame.new("0","0")
    assert_equal 0, @frame.score
  end

  def test_frame_score4
    @frame = Frame.new("0","0","0")
    assert_equal 0, @frame.score
  end

  def test_frame_score5
    @frame = Frame.new("X","X","X")
    assert_equal 30, @frame.score
  end

  def test_frame_score6
    @frame = Frame.new("X","X","5")
    assert_equal 25, @frame.score
  end

  def test_frame_score7
    @frame = Frame.new("2","8","5")
    assert_equal 15, @frame.score
  end

  def test_strike?
    @frame = Frame.new("X")
    assert_equal true, @frame.strike?
  end

  def test_strike?
    @frame = Frame.new("3","7")
    assert_equal false, @frame.strike?
  end

  def test_spare?
    @frame = Frame.new("3","7")
    assert_equal true, @frame.spare?
  end

  def test_spare?
    @frame = Frame.new("2","6")
    assert_equal false, @frame.spare?
  end
end
