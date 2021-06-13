require_relative 'bowling'#自ファイルからの相対パス
require 'minitest/autorun'

class BowlingTest < Minitest::Test
  def test_add_point
    assert_equal 139, main("6, 3, 9, 0, 0, 3, 8, 2, 7, 3, X, 9, 1, 8, 0, X, 6, 4, 5")
    assert_equal 164, main("6, 3, 9, 0, 0, 3, 8, 2, 7, 3, X, 9, 1, 8, 0, X, X, X, X")
    assert_equal 107, add_point("0, 10, 1, 5, 0, 0, 0, 0, X, X, X, 5, 1, 8, 1, 0, 4")
    assert_equal 134, add_point("6, 3, 9, 0, 0, 3, 8, 2, 7, 3, X, 9, 1, 8, 0, X, X, 0, 0")
    assert_equal 300, add_point("X, X, X, X, X, X, X, X, X, X, X, X")
  end
end
