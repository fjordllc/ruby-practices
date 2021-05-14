require 'minitest/autorun'
require_relative '../lib/bowling_score_calculater.rb'

class CalculateTest < Minitest::Test  
  def test_calculate_
    assert_equal 139, calculate('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 164, calculate('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    assert_equal 107, calculate('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal 134, calculate('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    assert_equal 300, calculate('X,X,X,X,X,X,X,X,X,X,X,X')
  end
end