# frozen_string_literal: true
# rubocop:disable all

require 'minitest/autorun'
require_relative 'game'
require_relative 'shot'
require_relative 'frame'

class GameTest < Minitest::Unit::TestCase
  def test_calc1
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 139, game.score
  end

  def test_calc2
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    assert_equal 164, game.score
  end

  def test_calc3
    game = Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal 107, game.score
  end

  def test_calc4
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    assert_equal 134, game.score
  end

  def test_calc5
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal 300, game.score
  end

  def 一度スコアを確認した後に再度スコアを確認しても同じ結果を得ることができる
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    game.score
    reconfirmation = game.score
    assert_equal 139, reconfirmation
  end
end
