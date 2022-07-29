# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'ls'

PATH_0 = 'ls-test-dir/ls0'
PATH_1 = 'ls-test-dir/ls1'
PATH_2 = 'ls-test-dir/ls2'
PATH_3 = 'ls-test-dir/ls3'
PATH_4 = 'ls-test-dir/ls4'
PATH_5 = 'ls-test-dir/ls5'
PATH_10 = 'ls-test-dir/ls10'

class LsTest < Minitest::Test
  def test_ls_nothing
    expected = ''
    assert_equal expected, ls(PATH_0)
  end
end
