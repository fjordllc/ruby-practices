#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/bowling_object'


class BowlingObjectTest < Minitest::Test
  def test_calc_scores_no_strike_spare
    game = Game.new("6,3,9,0,0,3,8,1,7,2,5,2,9,0,8,0,3,6,3")
    assert_equal 75, game.calc_scores
  end

  def test_calc_scores_strike_spare
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 139, game.calc_scores
  end

  def test_calc_scores_consecutive_strikes
    game = Game.new("0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4")
    assert_equal 107, game.calc_scores
  end

  def test_calc_scores_perfect
    game = Game.new("X,X,X,X,X,X,X,X,X,X,X,X")
    assert_equal 300, game.calc_scores
  end
end
