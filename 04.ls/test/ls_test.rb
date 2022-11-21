require 'minitest/autorun'
require_relative '../lib/ls'

class ListenTest < Minitest::Test
  def test_get_file_list
    assert_equal 26, get_file_list.size
  end
end
