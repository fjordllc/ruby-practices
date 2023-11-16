require 'minitest/autorun'
require_relative '../lib/shot'

class ShotTest < Minitest::Test
  def test_score
    assert_equal 2, Shot.new('2').score
    assert_equal 10, Shot.new('X').score
  end
end
