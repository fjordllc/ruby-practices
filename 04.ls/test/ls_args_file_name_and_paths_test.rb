# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class ListArgsFileNameAndPathsTest < Minitest::Test
  def test_make_disp_list_when_args_file_name_and_paths
    assert_equal "#{__dir__}/test_data/01_file  #{__dir__}/test_data/03_file  ", make_disp_list(parse_option)[0]
    assert_equal "\n", make_disp_list(parse_option)[1]
    assert_equal "#{__dir__}/test_data/02dir:", make_disp_list(parse_option)[2]
    assert_equal '20_file        23_あああ              あ_file          ', make_disp_list(parse_option)[3]
    assert_equal '21_file        24_looooong_name_file  あいうえお_file  ', make_disp_list(parse_option)[4]
    assert_equal '22_あああfile  25_file                ', make_disp_list(parse_option)[5]
    assert_equal "\n", make_disp_list(parse_option)[6]
    assert_equal "#{__dir__}/test_data/04dir:", make_disp_list(parse_option)[7]
    assert_equal '05dir    21_file  ', make_disp_list(parse_option)[8]
    assert_equal '20_file  22_file  ', make_disp_list(parse_option)[9]
  end
end
