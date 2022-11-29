# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class ListOptionTest < Minitest::Test
  def test_glob_file_list_with_path
    p parse_option
    assert_equal "#{__dir__}/test_data/00dir", parse_option[0]
  end
end
