# frozen_string_literal: true

require 'minitest/autorun'
require './lib/filedata'
require './lib/filelist'
require './lib/show'

class LsTest < Minitest::Test
  TARGET_PATH = 'test/fixtures'
  TARGET_PATH_NO_SPRIT = 'test'

  def test_ls_short_format_sprit_into_column
    expected = <<~TEXT.chomp
      dir_foobar          dummy_file_002.txt  dummy_file_004.txt  lorem_ipsum_10p.txt lorem_ipsum_2p.txt  symlink_file.txt
      dummy_file_001.txt  dummy_file_003.txt  dummy_file_005.txt  lorem_ipsum_1p.txt  lorem_ipsum_5p.txt
    TEXT
    show = Show.new(TARGET_PATH)
    show.list_without_dotfile
    assert_equal expected, show.short_format_split_into_columns
  end

  def test_ls_short_format
    expected = <<~TEXT.chomp
      fixtures   ls_test.rb
    TEXT
    show = Show.new(TARGET_PATH_NO_SPRIT)
    show.list_without_dotfile
    assert_equal expected, show.short_format
  end

  def test_ls_show_dotfiles
    expected = <<~TEXT.chomp
      .                   dir_foobar          dummy_file_002.txt  dummy_file_004.txt  lorem_ipsum_10p.txt lorem_ipsum_2p.txt  symlink_file.txt
      ..                  dummy_file_001.txt  dummy_file_003.txt  dummy_file_005.txt  lorem_ipsum_1p.txt  lorem_ipsum_5p.txt
    TEXT
    show = Show.new(TARGET_PATH)
    show.list_contain_dotfile
    assert_equal expected, show.short_format_split_into_columns
  end

  def test_ls_reverse
    expected = <<~TEXT.chomp
      symlink_file.txt    lorem_ipsum_2p.txt  lorem_ipsum_10p.txt dummy_file_004.txt  dummy_file_002.txt  dir_foobar
      lorem_ipsum_5p.txt  lorem_ipsum_1p.txt  dummy_file_005.txt  dummy_file_003.txt  dummy_file_001.txt
    TEXT
    show = Show.new(TARGET_PATH)
    show.list_without_dotfile
    show.list_reverse
    assert_equal expected, show.short_format_split_into_columns
  end

  def test_ls_long_format
    expected = `ls -l #{TARGET_PATH}`.chomp
    show = Show.new(TARGET_PATH)
    show.list_without_dotfile
    show.list_file_stat
    assert_equal expected, show.long_format
  end

  def test_ls_all_options
    expected = `ls -arl #{TARGET_PATH}`.chomp
    show = Show.new(TARGET_PATH)
    show.list_contain_dotfile
    show.list_reverse
    show.list_file_stat
    assert_equal expected, show.long_format
  end
end
