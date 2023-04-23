#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require '~/Documents/Fjord/ruby-practices/04.ls/lib/my-ls'
require 'debug'

# 以下でテストすること
# cd ~/Documents/Fjord/ruby-practices/04.ls/test/test_target
# ruby ~/Documents/Fjord/ruby-practices/04.ls/test/test.rb

class TestFileNameReciever < Minitest::Test
  def test_get_file_names_no_argument
    assert_equal ['a_test.txt', 'b_test.rb', 'sub.dir', 'テスト-ターゲット.md', '試験.txt'], get_file_names('')
    # lsだと 'a_test.txt', 'b_test.rb', 'sub.dir', '試験.txt', 'テスト-ターゲット.md'
  end
  def test_get_file_names_dir_argument
    assert_equal ['a_test_sub.txt', 'b_test_sub.rb', 'テスト-ターゲット_sub.md', '試験_sub.txt'], get_file_names('sub.dir')
    # lsだと　'a_test_sub.txt', 'b_test_sub.rb', '試験_sub.txt', 'テスト-ターゲット_sub.md'
  end
  def test_get_file_names_file_argument
    # debugger
    assert_equal 'a_test.txt', get_file_names('a_test.txt')
    assert_equal '試験.txt', get_file_names('試験.txt')
    assert_equal 'テスト-ターゲット.md', get_file_names('テスト-ターゲット.md')
    assert_equal '.test', get_file_names('.test')
  end
end
