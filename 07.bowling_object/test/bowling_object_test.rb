#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/bowling_object'

class BowlingObjectTest < Minitest::Test
  def test_calc_scores_no_strike_spare
    game = Game.new('6,3,9,0,0,3,8,1,7,2,5,2,9,0,8,0,3,6,3')
    assert_equal 75, game.calc_scores
  end

  def test_calc_scores_strike
    game = Game.new('6,3,9,0,0,3,8,0,7,2,X,9,0,8,0,X,6,3')
    assert_equal 102, game.calc_scores
  end

  def test_calc_scores_spare
    game = Game.new('6,3,9,0,0,3,8,1,7,3,1,0,9,0,8,0,1,9,6,3')
    assert_equal 84, game.calc_scores
  end

  def test_calc_scores_consecutive_strikes
    game = Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal 107, game.calc_scores
  end

  def test_calc_scores_perfect
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal 300, game.calc_scores
  end
end
