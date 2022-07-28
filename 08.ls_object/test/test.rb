# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class LsTest < MiniTest::Test # rubocop:disable Metrics/ClassLength
  TARGET_PATH = Pathname('test/sample-app')

  def test_run_width1
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: false,
                      long_format: false,
                      reverse: false
                    }, 1)
    expected = <<~TEST.chomp
      favicon.svg
      index.html
      package.json
      public
      src
      tsconfig.json
    TEST

    assert_equal(expected, ls.run)
  end

  def test_run_width29
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: false,
                      long_format: false,
                      reverse: false
                    }, 29)
    expected = <<~TEST.chomp
      favicon.svg
      index.html
      package.json
      public
      src
      tsconfig.json
    TEST

    assert_equal(expected, ls.run)
  end

  def test_run_width44
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: false,
                      long_format: false,
                      reverse: false
                    }, 44)
    expected = <<~TEST.chomp
      favicon.svg    public
      index.html     src
      package.json   tsconfig.json
    TEST

    assert_equal(expected, ls.run)
  end

  def test_run_width45
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: false,
                      long_format: false,
                      reverse: false
                    }, 45)
    expected = <<~TEST.chomp
      favicon.svg    package.json   src
      index.html     public         tsconfig.json
    TEST

    assert_equal(expected, ls.run)
  end

  def test_run_with_dots_width59
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: true,
                      long_format: false,
                      reverse: false
                    }, 59)
    expected = <<~TEST.chomp
      .              index.html     src
      .gitignore     package.json   tsconfig.json
      favicon.svg    public
    TEST

    assert_equal(expected, ls.run)
  end

  def test_run_with_dots_width60
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: true,
                      long_format: false,
                      reverse: false
                    }, 60)
    expected = <<~TEST.chomp
      .              favicon.svg    package.json   src
      .gitignore     index.html     public         tsconfig.json
    TEST

    assert_equal(expected, ls.run)
  end

  def test_run_reverse_width45
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: false,
                      long_format: false,
                      reverse: true
                    }, 45)
    expected = <<~TEST.chomp
      tsconfig.json  public         index.html
      src            package.json   favicon.svg
    TEST

    assert_equal(expected, ls.run)
  end

  # long_formatのテストはユーザー名などが環境が違うと変わるため壊れます
  def test_run_long
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: false,
                      long_format: true,
                      reverse: false
                    }, 60)
    expected = <<~TEST.chomp
      total 32
      -rw-r--r--  1 AntiSatori  staff  1524  7 27 19:17 favicon.svg
      -rw-r--r--  1 AntiSatori  staff   356  7 28 23:10 index.html
      -rw-r--r--  1 AntiSatori  staff   267  7 27 19:17 package.json
      drwxr-xr-x  3 AntiSatori  staff    96  7 27 19:17 public
      drwxr-xr-x  7 AntiSatori  staff   224  7 27 19:17 src
      -rw-r--r--  1 AntiSatori  staff   468  7 27 19:17 tsconfig.json
    TEST

    assert_equal(expected, ls.run)
  end

  def test_run_long_with_dots
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: true,
                      long_format: true,
                      reverse: false
                    }, 60)
    expected = <<~TEST.chomp
      total 40
      drwxr-xr-x  9 AntiSatori  staff   288  7 27 19:17 .
      -rw-r--r--  1 AntiSatori  staff   253  7 27 19:17 .gitignore
      -rw-r--r--  1 AntiSatori  staff  1524  7 27 19:17 favicon.svg
      -rw-r--r--  1 AntiSatori  staff   356  7 28 23:10 index.html
      -rw-r--r--  1 AntiSatori  staff   267  7 27 19:17 package.json
      drwxr-xr-x  3 AntiSatori  staff    96  7 27 19:17 public
      drwxr-xr-x  7 AntiSatori  staff   224  7 27 19:17 src
      -rw-r--r--  1 AntiSatori  staff   468  7 27 19:17 tsconfig.json
    TEST

    assert_equal(expected, ls.run)
  end

  def test_run_alr
    ls = Ls::Ls.new(TARGET_PATH, {
                      dot_match: true,
                      long_format: true,
                      reverse: true
                    }, 60)
    expected = <<~TEST.chomp
      total 40
      -rw-r--r--  1 AntiSatori  staff   468  7 27 19:17 tsconfig.json
      drwxr-xr-x  7 AntiSatori  staff   224  7 27 19:17 src
      drwxr-xr-x  3 AntiSatori  staff    96  7 27 19:17 public
      -rw-r--r--  1 AntiSatori  staff   267  7 27 19:17 package.json
      -rw-r--r--  1 AntiSatori  staff   356  7 28 23:10 index.html
      -rw-r--r--  1 AntiSatori  staff  1524  7 27 19:17 favicon.svg
      -rw-r--r--  1 AntiSatori  staff   253  7 27 19:17 .gitignore
      drwxr-xr-x  9 AntiSatori  staff   288  7 27 19:17 .
    TEST

    assert_equal(expected, ls.run)
  end
end
