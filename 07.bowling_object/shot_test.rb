require 'minitest/autorun'
require_relative 'shot'

class ShotTest < Minitest::Unit::TestCase
  def test_Xが渡されたら10に変換
    shot = Shot.new('X')
    assert_equal 10, shot.score
  end

  def test_数字が渡されたら整数オブジェクトに
    shot = Shot.new('1')
    assert_equal 1, shot.score
  end
end
