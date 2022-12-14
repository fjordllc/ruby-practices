# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class ListTest < Minitest::Test
  attr_reader :test_data_dir

  def setup
    @test_data_dir = "#{__dir__}/test_data"
  end

  def test_current_dir_list_diplay
    current_dir = Dir.pwd
    Dir.chdir(test_data_dir)
    ls_path = "#{__dir__.sub!(%r{/test$}, '')}/lib/ls.rb"
    output = `ruby #{ls_path}`
    true_str =
      "00_file  04dir    13_file            \n"\
      "00dir    05_file  14_file            \n"\
      "01_file  06_file  15_file            \n"\
      "01dir    07_file  16_file            \n"\
      "02_file  08_file  17_file            \n"\
      "02dir    09_file  18_file            \n"\
      "03_file  10_file  19_file            \n"\
      "03dir    11_file  attr_file          \n"\
      "04_file  12_file  make_test_file.rb  \n"
    assert_equal true_str, output
    Dir.chdir(current_dir)
  end

  def test_dir_list_diplay_with_option_a
    current_dir = Dir.pwd
    Dir.chdir(test_data_dir)
    ls_path = "#{__dir__.sub!(%r{/test$}, '')}/lib/ls.rb"
    output = `ruby #{ls_path} #{test_data_dir} -a`
    true_str =
    ".        03_file  12_file            \n"\
    ".dir     03dir    13_file            \n"\
    ".dir2    04_file  14_file            \n"\
    ".file    04dir    15_file            \n"\
    ".file2   05_file  16_file            \n"\
    "00_file  06_file  17_file            \n"\
    "00dir    07_file  18_file            \n"\
    "01_file  08_file  19_file            \n"\
    "01dir    09_file  attr_file          \n"\
    "02_file  10_file  make_test_file.rb  \n"\
    "02dir    11_file  \n"
    assert_equal true_str, output
    Dir.chdir(current_dir)
  end

  def test_adjust_list_to_display
    files = Dir.glob('*', base: test_data_dir)
    assert_equal '00_file  04dir    13_file            ', adjust_list_to_display(files)[0]
  end

  def test_glob_file_list_with_path
    result = `ruby #{__dir__}/ls_option_test.rb #{test_data_dir}/00dir`
    assert result.include?('0 failures, 0 errors, 0 skips')
  end

  def test_adjust_list_to_display_when_there_are_3_files
    files = Dir.glob('*', base: "#{test_data_dir}/03dir")
    assert_equal '20_file  21_file  22_file  ', adjust_list_to_display(files)[0]
  end

  def test_adjust_list_to_display_when_there_is_0_file
    files = Dir.glob('*', base: "#{test_data_dir}/04dir/05dir")
    assert_nil adjust_list_to_display(files)[0]
  end

  def test_make_display_list_with_multiple_paths
    result = `ruby #{__dir__}/ls_multiple_options_test.rb #{__dir__}/test_data/00dir #{__dir__}/test_data/01dir`
    assert result.include?('0 failures, 0 errors, 0 skips')
  end

  # ファイルが指定された場合
  def test_make_display_list_with_file_name
    result = `ruby #{__dir__}/ls_args_file_name_test.rb #{__dir__}/test_data/01_file`
    assert result.include?('0 failures, 0 errors, 0 skips')
  end

  # ファイルとパスが複数指定された場合
  def test_make_display_list_with_file_name_and_paths
    result = `ruby #{__dir__}/ls_args_file_name_and_paths_test.rb \
    #{__dir__}/test_data/01_file #{__dir__}/test_data/02dir \
    #{__dir__}/test_data/03_file #{__dir__}/test_data/04dir`
    assert result.include?('0 failures, 0 errors, 0 skips')
  end
end
