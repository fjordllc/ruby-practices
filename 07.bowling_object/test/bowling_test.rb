# frozen_string_literal: true

require 'minitest/autorun'
require './lib/bowling'

class ShotTest < Minitest::Test
  def test_score
    # Puts score point 0 between 9.
    score0between9 = Shot.new('6')
    assert_equal 6, score0between9.score

    # Puts score point 10.
    score_x = Shot.new('X')
    assert_equal 10, score_x.score
  end

  def test_frame
    # Puts frame total score
    frame = Frame.new('1', '4', '7')
    assert_equal 5, frame.score

    # Puts addition next frame first shot score when spare
    frame_pattern_spare = Frame.new('2', '8', '7')
    assert_equal 17, frame_pattern_spare.score

    # Puts addition next frame first and second shot score when strike
    frame_pattern_strike = Frame.new('X', '2', '3')
    assert_equal 15, frame_pattern_strike.score
  end

  def test_game
    game_score1 = Game.new('6390038273X9180XXXX')
    assert_equal 164, game_score1.score

    game_score2 = Game.new('6390038273X9180X645')
    assert_equal 139, game_score2.score

    game_score3 = Game.new('0X150000XXX518104')
    assert_equal 107, game_score3.score

    game_score4 = Game.new('6390038273X9180XX00')
    assert_equal 134, game_score4.score

    game_score4 = Game.new('XXXXXXXXXXXX')
    assert_equal 300, game_score4.score
  end

  def test_hoge
    p game = Game.new('6390038273X9180XX00')
    p game.score
  end
end
