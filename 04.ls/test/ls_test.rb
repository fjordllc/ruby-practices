require 'minitest/autorun'
require_relative '../lib/ls'

class ListTest < Minitest::Test
  def test_make_file_list
    assert_equal 26, make_file_list.size
  end

  def test_make_disp_lines
    assert_equal '00_file  04dir    13_file            ' ,make_disp_lines[0]
  end
end
