# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'ls'

PATH_0 = 'ls-test-dir/ls0'
PATH_1 = 'ls-test-dir/ls1'
PATH_2 = 'ls-test-dir/ls2'
PATH_3 = 'ls-test-dir/ls3'
PATH_4 = 'ls-test-dir/ls4'
PATH_5 = 'ls-test-dir/ls5'
PATH_6 = 'ls-test-dir/ls6'
PATH_7 = 'ls-test-dir/ls7'
PATH_8 = 'ls-test-dir/ls8'
PATH_9 = 'ls-test-dir/ls9'
PATH_10 = 'ls-test-dir/ls10'
PATH_DOT = 'ls-test-dir/ls-dot'
PATH_FILETYPE = 'ls-test-dir/ls-filetype'
OPTIONS_EMPTY = {}.freeze
OPTIONS_A = { a: true }.freeze
OPTIONS_R = { r: true }.freeze
OPTIONS_L = { l: true }.freeze
OPTIONS_AR = { a: true, r: true }.freeze

class LsTest < Minitest::Test
  def test_ls_nothing
    expected = ''
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_0)
  end

  def test_ls_file1
    expected = ['a.txt    ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_1)
  end

  def test_ls_file2
    expected = ['aaaaa.txt    bbbbb.txt    ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_2)
  end

  def test_ls_file3
    expected = ['aaaaa.txt    bbbbb.txt    ccccc.txt    ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_3)
  end

  def test_ls_file4
    expected = ['aaaaa.txt    ccccc.txt    ',
                'bbbbb.txt    ddddd.txt    ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_4)
  end

  def test_ls_file5
    expected = ['aaaaa.txt    ccccc.txt    eeeee.txt    ',
                'bbbbb.txt    ddddd.txt                 ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_5)
  end

  def test_ls_file6
    expected = ['aaaaa.txt    ccccc.txt    eeeee.txt    ',
                'bbbbb.txt    ddddd.txt    fffff.txt    ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_6)
  end

  def test_ls_file7
    expected = ['aaaaa.txt    ddddd.txt    ggggg.txt    ',
                'bbbbb.txt    eeeee.txt                 ',
                'ccccc.txt    fffff.txt                 ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_7)
  end

  def test_ls_file8
    expected = ['aaaaa.txt    ddddd.txt    ggggg.txt    ',
                'bbbbb.txt    eeeee.txt    hhhhh.txt    ',
                'ccccc.txt    fffff.txt                 ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_8)
  end

  def test_ls_file9
    expected = ['aaaaa.txt    ddddd.txt    ggggg.txt    ',
                'bbbbb.txt    eeeee.txt    hhhhh.txt    ',
                'ccccc.txt    fffff.txt    iiiii.txt    ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_9)
  end

  def test_ls_file10
    expected = ['aaaaa.txt    eeeee.txt    iiiii.txt    ',
                'bbbbb.txt    fffff.txt    jjjjj.txt    ',
                'ccccc.txt    ggggg.txt                 ',
                'ddddd.txt    hhhhh.txt                 ']
    assert_equal expected, ls(OPTIONS_EMPTY, PATH_10)
  end

  def test_ls_file_dot
    expected = ['.            ccccc.txt    hhhhh.txt    ',
                '.aaaaa       ddddd.txt    iiiii.txt    ',
                '.bbbbb       eeeee.txt    jjjjj.txt    ',
                'aaaaa.txt    fffff.txt                 ',
                'bbbbb.txt    ggggg.txt                 ']
    assert_equal expected, ls(OPTIONS_A, PATH_DOT)
  end

  def test_ls_file10_r
    expected = ['jjjjj.txt    fffff.txt    bbbbb.txt    ',
                'iiiii.txt    eeeee.txt    aaaaa.txt    ',
                'hhhhh.txt    ddddd.txt                 ',
                'ggggg.txt    ccccc.txt                 ']
    assert_equal expected, ls(OPTIONS_R, PATH_10)
  end

  def test_ls_option_ar
    expected = ['jjjjj.txt    eeeee.txt    .bbbbb       ',
                'iiiii.txt    ddddd.txt    .aaaaa       ',
                'hhhhh.txt    ccccc.txt    .            ',
                'ggggg.txt    bbbbb.txt                 ',
                'fffff.txt    aaaaa.txt                 ']
    assert_equal expected, ls(OPTIONS_AR, PATH_DOT)
  end

  def test_ls_option_l
    expected = ['total 8',
                '-rw-r--r--  1 kanoko staff  1667  8 10 22:36 aaaaa.txt',
                'drwxr-xr-x  2 kanoko staff    64  8  3 23:23 bbbbb-dir',
                'lrwxr-xr-x  1 kanoko staff    54  8  7 21:28 ls0 -> /Users/kanoko/Dev/ruby-practices/05.ls/ls-test-dir/ls0']
    assert_equal expected, ls(OPTIONS_L, PATH_FILETYPE)
  end
end
