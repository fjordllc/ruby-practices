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

class LsTest < Minitest::Test
  def test_ls_nothing
    expected = ''
    assert_equal expected, ls(PATH_0)
  end

  def test_ls_file1
    expected = ['a.txt    ']
    assert_equal expected, ls(PATH_1)
  end

  def test_ls_file2
    expected = ['aaaaa.txt    bbbbb.txt    ']
    assert_equal expected, ls(PATH_2)
  end

  def test_ls_file3
    expected = ['aaaaa.txt    bbbbb.txt    ccccc.txt    ']
    assert_equal expected, ls(PATH_3)
  end

  def test_ls_file4
    expected = ['aaaaa.txt    ccccc.txt    ',
                'bbbbb.txt    ddddd.txt    ']
    assert_equal expected, ls(PATH_4)
  end

  def test_ls_file5
    expected = ['aaaaa.txt    ccccc.txt    eeeee.txt    ',
                'bbbbb.txt    ddddd.txt                 ']
    assert_equal expected, ls(PATH_5)
  end

  def test_ls_file6
    expected = ['aaaaa.txt    ccccc.txt    eeeee.txt    ',
                'bbbbb.txt    ddddd.txt    fffff.txt    ']
    assert_equal expected, ls(PATH_6)
  end

  def test_ls_file7
    expected = ['aaaaa.txt    ddddd.txt    ggggg.txt    ',
                'bbbbb.txt    eeeee.txt                 ',
                'ccccc.txt    fffff.txt                 ']
    assert_equal expected, ls(PATH_7)
  end

  def test_ls_file8
    expected = ['aaaaa.txt    ddddd.txt    ggggg.txt    ',
                'bbbbb.txt    eeeee.txt    hhhhh.txt    ',
                'ccccc.txt    fffff.txt                 ']
    assert_equal expected, ls(PATH_8)
  end

  def test_ls_file9
    expected = ['aaaaa.txt    ddddd.txt    ggggg.txt    ',
                'bbbbb.txt    eeeee.txt    hhhhh.txt    ',
                'ccccc.txt    fffff.txt    iiiii.txt    ']
    assert_equal expected, ls(PATH_9)
  end

  def test_ls_file10
    expected = ['aaaaa.txt    eeeee.txt    iiiii.txt    ',
                'bbbbb.txt    fffff.txt    jjjjj.txt    ',
                'ccccc.txt    ggggg.txt                 ',
                'ddddd.txt    hhhhh.txt                 ']
    assert_equal expected, ls(PATH_10)
  end
end
