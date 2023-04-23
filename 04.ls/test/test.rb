#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require '~/Documents/Fjord/ruby-practices/04.ls/lib/my-ls'
require 'debug'

# 以下でテストすること
# cd ~/Documents/Fjord/ruby-practices/04.ls/test/test_target
# ruby ~/Documents/Fjord/ruby-practices/04.ls/test/test.rb

class TestNameReciever < Minitest::Test
  def test_get_file_names_no_argument
    assert_equal ['a_test.txt', 'b_test.rb', 'sub.dir', 'テスト-ターゲット.md', '試験.txt'], get_file_names('')
    # lsだと 'a_test.txt', 'b_test.rb', 'sub.dir', '試験.txt', 'テスト-ターゲット.md'
  end
  def test_get_file_names_dir_argument
    assert_equal ['a_test_sub.txt', 'b_test_sub.rb', 'テスト-ターゲット_sub.md', '試験_sub.txt'], get_file_names('sub.dir')
    # lsだと　'a_test_sub.txt', 'b_test_sub.rb', '試験_sub.txt', 'テスト-ターゲット_sub.md'
    assert_equal ['test.rb', 'test_target'], get_file_names('..')
    assert_equal ['test.rb', 'test_target'], get_file_names('/Users/atsushi/Documents/Fjord/ruby-practices/04.ls/test')
    assert_equal ['test.rb', 'test_target'], get_file_names('~/Documents/Fjord/ruby-practices/04.ls/test/')
  end
  def test_get_file_names_file_argument
    # debugger
    assert_equal 'a_test.txt', get_file_names('a_test.txt')
    assert_equal '試験.txt', get_file_names('試験.txt')
    assert_equal 'テスト-ターゲット.md', get_file_names('テスト-ターゲット.md')
    assert_equal '.test', get_file_names('.test')
  end
end

class TestGenerationNameListText < Minitest::Test
  def test_generate_name_list_text_only_alphabet
      assert_equal "abc bc \n", generate_name_list_text(['abc','bc'], 3)
      assert_equal "abc bc  c  \n", generate_name_list_text(['abc','bc','c'], 3)
      assert_equal "abc c  \nbc  d  \n", generate_name_list_text(['abc','bc','c','d'], 3)
  end

  def test_generate_name_list_text_with_japanese
    result_text = <<~TEXT
    life.md    楽ありゃ   苦もあるさ
    人生       happy.rb              
    TEXT
    assert_equal result_text, generate_name_list_text(['life.md', '人生', '楽ありゃ', 'happy.rb', '苦もあるさ'], 3)
  end

  def test_generate_name_list_text_with_files
    result_text = <<~TEXT
    a_test.txt           sub.dir           試験.txt            
    b_test.rb            テスト-ターゲット.md                     
    TEXT
    assert_equal result_text, generate_name_list_text(['a_test.txt', 'b_test.rb', 'sub.dir', 'テスト-ターゲット.md', '試験.txt'], 3)
  end
end
