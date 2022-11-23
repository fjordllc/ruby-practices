# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class ListTest < Minitest::Test
  attr_reader :test_data_dir

  def setup
    @test_data_dir = "#{__dir__}/test_data"
  end

  def test_glob_file_list
    assert_equal 27, glob_file_list(test_data_dir).size
  end

  def test_adjust_list_to_disp
    files = glob_file_list(test_data_dir)
    assert_equal '00_file  04dir    13_file            ', adjust_list_to_disp(files)[0]
  end

  def test_glob_file_list_with_path
    result = `ruby #{__dir__}/ls_option_test.rb 00dir`
    assert result.include?('0 failures, 0 errors, 0 skips')
  end

  def test_adjust_list_to_disp_when_there_are_3_files
    files = glob_file_list("#{test_data_dir}/03dir")
    assert_equal '20_file  21_file  22_file  ', adjust_list_to_disp(files)[0]
  end

  def test_adjust_list_to_disp_when_there_is_0_file
    files = glob_file_list("#{test_data_dir}/04dir/05dir")
    assert_nil adjust_list_to_disp(files)[0]
  end

  def test_make_disp_list_with_multiple_paths
    result = `ruby #{__dir__}/ls_multiple_options_test.rb #{__dir__}/test_data/00dir #{__dir__}/test_data/01dir`
    assert result.include?('0 failures, 0 errors, 0 skips')
  end

  # ファイルが指定された場合
  def test_make_disp_list_with_file_name
    result = `ruby #{__dir__}/ls_args_file_name_test.rb #{__dir__}/test_data/01_file`
    assert result.include?('0 failures, 0 errors, 0 skips')
  end

  # ファイルとパスが複数指定された場合
  def test_make_disp_list_with_file_name_and_paths
    result = `ruby #{__dir__}/ls_args_file_name_and_paths_test.rb \
    #{__dir__}/test_data/01_file #{__dir__}/test_data/02dir \
    #{__dir__}/test_data/03_file #{__dir__}/test_data/04dir`
    assert result.include?('0 failures, 0 errors, 0 skips')
  end
end
