# frozen_string_literal: true

require 'test/unit'
require_relative 'shot'
require_relative 'frame'
require_relative 'game'

class BowlingTest < Test::Unit::TestCase
  def test_game1
    throwings = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'.split(',')
    shots = throwings.map { |throwing| Shot.new(throwing) }
    divided_shots = Frame.divide(shots)
    frames = divided_shots.map { |divided_shot| Frame.new(*divided_shot) }
    assert_equal 139, Game.new(frames).score
  end

  def test_game2
    throwings = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'.split(',')
    shots = throwings.map { |throwing| Shot.new(throwing) }
    divided_shots = Frame.divide(shots)
    frames = divided_shots.map { |divided_shot| Frame.new(*divided_shot) }
    assert_equal 164, Game.new(frames).score
  end

  def test_game3
    throwings = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'.split(',')
    shots = throwings.map { |throwing| Shot.new(throwing) }
    divided_shots = Frame.divide(shots)
    frames = divided_shots.map { |divided_shot| Frame.new(*divided_shot) }
    assert_equal 107, Game.new(frames).score
  end

  def test_game4
    throwings = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'.split(',')
    shots = throwings.map { |throwing| Shot.new(throwing) }
    divided_shots = Frame.divide(shots)
    frames = divided_shots.map { |divided_shot| Frame.new(*divided_shot) }
    assert_equal 134, Game.new(frames).score
  end

  def test_game5
    throwings = 'X,X,X,X,X,X,X,X,X,X,X,X'.split(',')
    shots = throwings.map { |throwing| Shot.new(throwing) }
    divided_shots = Frame.divide(shots)
    frames = divided_shots.map { |divided_shot| Frame.new(*divided_shot) }
    assert_equal 300, Game.new(frames).score
  end
end
