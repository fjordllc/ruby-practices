# frozen_string_literal: true

require './lib/game'
require 'minitest/autorun'

class BowlingOopTest < Minitest::Test
  def test_shot_class
    shot1 = Shot.new('6')
    assert_equal 6, shot1.roll_to_integer
    shot2 = Shot.new('X')
    assert_equal 10, shot2.roll_to_integer
  end

  def test_frame_class
    frame1 = Frame.new('4', '3')
    assert_equal 7, frame1.score
    frame2 = Frame.new('X')
    assert frame2.strike?
    assert !frame2.spare?
    frame3 = Frame.new('1', '9')
    assert frame3.spare?
    assert !frame3.strike?
  end

  def test_game_class
    game = Game.new('6390038273X9180X645')
    assert_equal [%w[6 3], %w[9 0], %w[0 3], %w[8 2], %w[7 3], ['X'], %w[9 1], %w[8 0], ['X'], %w[6 4 5]], game.pinfall_to_frames
    assert_equal [9, 9, 3, 17, 20, 20, 18, 8, 20, 15], game.points_per_frame
  end

  def test_game_calc1
    game = Game.new('6390038273X9180X645')
    assert_equal 139, game.score
  end

  def test_game_calc2
    game = Game.new('6390038273X9180XXXX')
    assert_equal 164, game.score
  end

  def test_game_calc3
    game = Game.new('0X150000XXX518104')
    assert_equal 107, game.score
  end

  def test_game_calc4
    game = Game.new('6390038273X9180XX00')
    assert_equal 134, game.score
  end

  def test_game_calc5
    game = Game.new('X' * 12)
    assert_equal 300, game.score
  end

  def test_game_calc6
    game = Game.new('00' * 10)
    assert_equal 0, game.score
  end
end
