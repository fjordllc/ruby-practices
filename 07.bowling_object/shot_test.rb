# frozen_string_literal: true
# rubocop:disable all

require 'minitest/autorun'
require_relative 'shot'

class ShotTest < Minitest::Unit::TestCase
  def test_Xが渡されたら10に変換
    shot = Shot.new('X')
    assert_equal 10, shot.score
  end

  def test_数字が渡されたら整数オブジェクトに
    shot_1 = Shot.new('1')
    shot_2 = Shot.new('5')
    assert_equal 1, shot_1.score
    assert_equal 5, shot_2.score
  end
end
