# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'


class ListTest < Minitest::Test
  @@test_data_dir = "#{__dir__ }/test_data"
  def test_make_file_list
    assert_equal 26, make_file_list(@@test_data_dir).size
  end

  def test_make_disp_lines
    assert_equal '00_file  04dir    13_file            ', make_disp_lines(@@test_data_dir)[0]
  end

  def test_make_file_list_with_path
    result = `ruby #{__dir__}/ls_option_test.rb 00dir`
    assert result.include?('1 runs, 1 assertions, 0 failures, 0 errors, 0 skips')
  end

  def test_make_disp_lines_when_there_are_3_files
    assert_equal '20_file  21_file  22_file  ', make_disp_lines("#{@@test_data_dir}/03dir")[0]
  end

  def test_make_disp_lines_when_there_is_0_file
    assert_nil make_disp_lines("#{@@test_data_dir}/04dir/05dir")[0]
  end

  def test_make_disp_lines_with_multiple_paths
    
    result = `ruby #{__dir__}/ls_multiple_options_test.rb #{__dir__}/test_data/00dir #{__dir__}/test_data/01dir`
    assert result.include?('1 runs, 6 assertions, 0 failures, 0 errors, 0 skips')
  end
  
end
