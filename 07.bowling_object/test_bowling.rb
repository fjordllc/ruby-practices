# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'main'

class BowlingTest < Minitest::Test
  def main
    assert_equal 164, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5').sum_up
    assert_equal 164, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X').sum_up
    assert_equal 107, Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4').sum_up
    assert_equal 134, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0').sum_up
    assert_equal 300, Game.new('X,X,X,X,X,X,X,X,X,X,X,X').sum_up
  end
end
