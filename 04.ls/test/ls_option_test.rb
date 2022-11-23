# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class ListOptionTest < Minitest::Test
  def test_glob_file_list_with_path
    assert_equal '00dir', parse_option[0]
  end
end
