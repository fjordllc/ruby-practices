#!/usr/bin/env ruby

# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'
require 'tmpdir'
require 'fileutils'
require 'stringio'
require 'io/console/size'

class TestTools
  attr_reader :test_dir

  def initialize
    @test_dir = Dir.mktmpdir
  end

  def create_tmp_files(num_of_ascii = 1, num_of_ja = 0, auto_clean: true)
    tmp_files = []
    if num_of_ascii.positive?
      (1..num_of_ascii).each do |n|
        File.open("#{@test_dir}/test_file#{n}", 'w+') {}
        tmp_files << "test_file#{n}"
      end
    end

    if num_of_ja.positive?
      (1..num_of_ja).each do |n|
        File.open("#{@test_dir}/日本語のファイル#{n}", 'w+') {}
        tmp_files << "日本語のファイル#{n}"
      end
    end
    yield
    remove_entries(tmp_files) if auto_clean
  end

  def create_tmp_dirs(num_of_ascii = 1, num_of_ja = 0, auto_clean: true)
    tmp_dirs = []
    if num_of_ascii.positive?
      (1..num_of_ascii).each do |n|
        Dir.mkdir("#{@test_dir}/test_dir#{n}")
        tmp_dirs << "test_dir#{n}"
      end
    end

    if num_of_ja.positive?
      (1..num_of_ja).each do |n|
        Dir.mkdir("#{@test_dir}/日本語のディレクトリ#{n}")
        tmp_dirs << "日本語のディレクトリ#{n}"
      end
    end
    yield
    remove_entries(tmp_dirs) if auto_clean
  end

  # テストディレクトリ削除（再帰的に全て削除）
  def cleanup
    FileUtils.remove_entry_secure @test_dir
  end

  # テストディレクトリ内の削除
  def remove_entries(entries)
    entries.each do |entry|
      FileUtils.remove_entry_secure "#{@test_dir}/#{entry}"
    end
  end

  def capture_stdout(ls_instance)
    out = StringIO.new
    $stdout = out
    ls_instance.output
    out.string
  ensure
    $stdout = STDOUT
  end
end

class LsTest < Minitest::Test
  def setup
    @test_tools = TestTools.new
    # テストのために十分なコンソールの幅がなかった場合はエラーとする
    raise "テストに必要なコンソールの表示幅がありません。#{22 * 3}以上の幅を確保してください" if IO.console_size[1] < 66

    @test_ls = Ls.new
    @test_ls.entry_name = @test_tools.test_dir
  end

  def test_vacant_dir
    assert_equal '', @test_tools.capture_stdout(@test_ls)
  end

  def test_one_file_with_ascii_name
    @test_tools.create_tmp_files(1) do
      assert_equal "test_file1\n", @test_tools.capture_stdout(@test_ls)
    end
  end

  def test_one_file_with_japanese_name
    @test_tools.create_tmp_files(0, 1) do
      assert_equal "日本語のファイル1\n", @test_tools.capture_stdout(@test_ls)
    end
  end

  def test_one_dir_with_ascii_name
    @test_tools.create_tmp_dirs(1) do
      assert_equal "test_dir1\n", @test_tools.capture_stdout(@test_ls)
    end
  end

  def test_one_dir_with_japanese_name
    @test_tools.create_tmp_dirs(0, 1) do
      assert_equal "日本語のディレクトリ1\n", @test_tools.capture_stdout(@test_ls)
    end
  end

  def test_many_files_with_same_format
    expected = <<~TEXT
      test_file1 test_file4 test_file7
      test_file2 test_file5
      test_file3 test_file6
    TEXT
    @test_tools.create_tmp_files(7) do
      assert_equal expected, @test_tools.capture_stdout(@test_ls)
    end
  end

  def test_many_japanese_files_with_same_format
    expected = <<~TEXT
      日本語のファイル1 日本語のファイル4 日本語のファイル7
      日本語のファイル2 日本語のファイル5
      日本語のファイル3 日本語のファイル6
    TEXT
    @test_tools.create_tmp_files(0, 7) do
      assert_equal expected, @test_tools.capture_stdout(@test_ls)
    end
  end

  def test_many_files_mixed_format
    # test_file1 = 9スペース分 日本語のファイル1 = 17スペース分
    expected = <<~TEXT
      test_file1        test_file4        日本語のファイル3
      test_file2        日本語のファイル1
      test_file3        日本語のファイル2
    TEXT
    @test_tools.create_tmp_files(4, 3) do
      assert_equal expected, @test_tools.capture_stdout(@test_ls)
    end
  end

  def test_many_entries_mixed_format
    # test_file1 = 10スペース分
    # 日本語のファイル1 = 17スペース分
    # test_dir = 8スペース分
    # 日本語のディレクトリ1 = 21スペース分
    expected = <<~TEXT
      test_dir1             test_file2            日本語のファイル1
      test_dir2             日本語のディレクトリ1 日本語のファイル2
      test_file1            日本語のディレクトリ2
    TEXT

    @test_tools.create_tmp_files(2, 2, auto_clean: false) {}
    @test_tools.create_tmp_dirs(2, 2) do
      assert_equal expected, @test_tools.capture_stdout(@test_ls)
    end
  end

  def teardown
    @test_tools.cleanup
  end
end
