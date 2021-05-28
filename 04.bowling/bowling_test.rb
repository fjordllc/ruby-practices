require 'minitest/autorun'
require_relative './bowling'

class BowlingTest < Minitest::Test
  def test_all_strike
    # puts "test_all_strike"
    bowling = Bowling.new(['X,X,X,X,X,X,X,X,X,X,X,X'])
    assert_equal 300, bowling.run
  end

  def test_164
    # puts "test_164"
    bowling = Bowling.new(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'])
    assert_equal 164, bowling.run
  end

  def test_107
    # puts "test_107"
    bowling = Bowling.new(['0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'])
    assert_equal 107, bowling.run
  end

  def test_134
    # puts "test_134"
    bowling = Bowling.new(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'])
    assert_equal 134, bowling.run
  end
end
