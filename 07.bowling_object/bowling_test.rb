# frozen_string_literal: true

require './bowling_oop'
require 'minitest/autorun'

class BowlingTest < Minitest::Test
  def test_calc_x
    shot_x = Shot.new('X')
    assert_equal(10, shot_x.score)
  end

  def test_insert_zero_after_strike_shot_0X150000XXX51810X4 # rubocop:disable Naming/MethodName
    marks = '0X150000XXX51810X4'
    game = Game.new(marks)
    splitted_marks = marks.split('')
    splitted_scores = game.insert_zero_after_strike_shot(splitted_marks)
    assert_equal([0, 10, 1, 5, 0, 0, 0, 0, 10, 0, 10, 0, 10, 0, 5, 1, 8, 1, 0, 10, 4], splitted_scores)
  end

  def test_insert_zero_after_strike_shot_0X150000XXX518104 # rubocop:disable Naming/MethodName
    marks = '0X150000XXX518104'
    game = Game.new(marks)
    splitted_marks = marks.split('')
    splitted_scores = game.insert_zero_after_strike_shot(splitted_marks)
    assert_equal([0, 10, 1, 5, 0, 0, 0, 0, 10, 0, 10, 0, 10, 0, 5, 1, 8, 1, 0, 4], splitted_scores)
  end

  def test_calc_frames_score_0X150000XXX51810X4 # rubocop:disable Naming/MethodName
    marks = '0X150000XXX51810X4'
    game = Game.new(marks)
    splitted_marks = marks.split('')
    splitted_scores = game.insert_zero_after_strike_shot(splitted_marks)
    @frames = game.create_frames(splitted_scores)
    assert_equal 117, game.calc_frames_score
  end

  def test_calc_frames_score_0X150000XXX518104 # rubocop:disable Naming/MethodName
    marks = '0X150000XXX518104'
    game = Game.new(marks)
    splitted_marks = marks.split('')
    splitted_scores = game.insert_zero_after_strike_shot(splitted_marks)
    @frames = game.create_frames(splitted_scores)
    assert_equal 107, game.calc_frames_score
  end

  def test_calc_1 # rubocop:disable Naming/VariableNumber
    assert_equal 139, Game.new('6390038273X9180X645').calc_frames_score
  end

  def test_calc_2 # rubocop:disable Naming/VariableNumber
    assert_equal 164, Game.new('6390038273X9180XXXX').calc_frames_score
  end

  def test_calc_3 # rubocop:disable Naming/VariableNumber
    assert_equal 107, Game.new('0X150000XXX518104').calc_frames_score
  end

  def test_calc_4 # rubocop:disable Naming/VariableNumber
    assert_equal 117, Game.new('0X150000XXX51810X4').calc_frames_score
  end

  def test_calc_5 # rubocop:disable Naming/VariableNumber
    assert_equal 0, Game.new('000000000000000000000').calc_frames_score
  end

  def test_calc_6 # rubocop:disable Naming/VariableNumber
    assert_equal 300, Game.new('X' * 12).calc_frames_score
  end
end
