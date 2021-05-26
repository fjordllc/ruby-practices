require 'minitest/autorun'
require_relative './bowling'

class BowlingTest < Minitest::Test
  def test_all_strike
    assert_equal 300, Bowling.run(['X,X,X,X,X,X,X,X,X,X,X,X'])
  end
end

