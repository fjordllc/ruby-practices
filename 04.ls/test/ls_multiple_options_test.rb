# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class ListMultipleOptionTest < Minitest::Test
  def test_make_display_list_when_2_options_gived
    assert_equal "#{__dir__}/test_data/00dir:", make_display_list(parse_option)[0]
    assert_equal '20_file  22_file  24_file  ', make_display_list(parse_option)[1]
    assert_equal '21_file  23_file  25_file  ', make_display_list(parse_option)[2]
    assert_equal "\n", make_display_list(parse_option)[3]
    assert_equal "#{__dir__}/test_data/01dir:", make_display_list(parse_option)[4]
    assert_equal '30_file  32_file  34_file  ', make_display_list(parse_option)[5]
    assert_equal '31_file  33_file  35_file  ', make_display_list(parse_option)[6]
  end
end
