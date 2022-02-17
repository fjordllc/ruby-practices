#!/usr/bin/env ruby

# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'
require 'tmpdir'
require 'fileutils'
require 'stringio'

class TestTools
  attr_reader :test_dir

  def initialize
    # テスト用ディレクトリ生成
    @test_dir = Dir.mktmpdir
  end

  # ファイル生成
  def create_tmp_files(num = 1, is_ja: false)
    prefix = is_ja ? '日本語のファイル' : 'test_file'
    tmpfiles = []
    (1..num).each do |n|
      File.open("#{@test_dir}/#{prefix}#{n}", 'w+') { |file| file.write('test') }
      tmpfiles << "#{prefix}#{n}"
    end
    tmpfiles
  end

  # ディレクトリ生成
  def create_tmp_dirs(num = 1, is_ja: false)
    tmpdirs = []
    prefix = is_ja ? '日本語のディレクトリ' : 'test_dir'
    (1..num).each do |n|
      Dir.mkdir("#{@test_dir}/#{prefix}#{n}")
      tmpdirs << "#{prefix}#{n}"
    end
    tmpdirs
  end

  # テストディレクトリ削除（再帰的に全て削除）
  def cleanup
    FileUtils.remove_entry_secure @test_dir
  end

  # テストディレクトリ内の削除
  def remove_all_entries(entries)
    entries.each do |entry|
      FileUtils.remove_entry_secure "#{@test_dir}/#{entry}"
    end
  end

  # 標準出力のキャプチャ
  def capture_result(ls_instance)
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
    @test_ls = Ls.new(@test_tools.test_dir)
  end

  def test_one_file_with_ascii_name
    files = @test_tools.create_tmp_files(1)
    assert_equal "test_file1\n", @test_tools.capture_result(@test_ls)
    @test_tools.remove_all_entries(files)
  end

  def test_one_file_with_japanese_name
    files = @test_tools.create_tmp_files(1, is_ja: true)
    assert_equal "日本語のファイル1\n", @test_tools.capture_result(@test_ls)
    @test_tools.remove_all_entries(files)
  end

  def test_one_dir_with_ascii_name
    dirs = @test_tools.create_tmp_dirs(1)
    assert_equal "test_dir1\n", @test_tools.capture_result(@test_ls)
    @test_tools.remove_all_entries(dirs)
  end

  def test_one_dir_with_japanese_name
    dirs = @test_tools.create_tmp_dirs(1, is_ja: true)
    assert_equal "日本語のディレクトリ1\n", @test_tools.capture_result(@test_ls)
    @test_tools.remove_all_entries(dirs)
  end

  def test_many_files_with_same_format
    files = @test_tools.create_tmp_files(7)
    expected = <<~TEXT
      test_file1 test_file4 test_file7
      test_file2 test_file5
      test_file3 test_file6
    TEXT
    assert_equal expected, @test_tools.capture_result(@test_ls)
    @test_tools.remove_all_entries(files)
  end

  def test_many_japanese_files_with_same_format
    files = @test_tools.create_tmp_files(7, is_ja: true)
    expected = <<~TEXT
      日本語のファイル1 日本語のファイル4 日本語のファイル7
      日本語のファイル2 日本語のファイル5
      日本語のファイル3 日本語のファイル6
    TEXT
    assert_equal expected, @test_tools.capture_result(@test_ls)
    @test_tools.remove_all_entries(files)
  end

  def test_many_files_mixed_format
    entries = @test_tools.create_tmp_files(4)
    entries << @test_tools.create_tmp_files(3, is_ja: true)
    entries.flatten!
    # test_file1 = 9スペース分 日本語のファイル1 = 17スペース分
    expected = <<~TEXT
      test_file1        test_file4        日本語のファイル3
      test_file2        日本語のファイル1
      test_file3        日本語のファイル2
    TEXT
    assert_equal expected, @test_tools.capture_result(@test_ls)
    @test_tools.remove_all_entries(entries)
  end

  def test_many_entries_mixed_format
    entries = @test_tools.create_tmp_files(2)
    entries << @test_tools.create_tmp_files(2, is_ja: true)
    entries << @test_tools.create_tmp_dirs(2)
    entries << @test_tools.create_tmp_dirs(2, is_ja: true)
    entries.flatten!
    # test_file1 = 10スペース分
    # 日本語のファイル1 = 17スペース分
    # test_dir = 8スペース分
    # 日本語のディレクトリ1 = 21スペース分
    expected = <<~TEXT
      test_dir1             test_file2            日本語のファイル1
      test_dir2             日本語のディレクトリ1 日本語のファイル2
      test_file1            日本語のディレクトリ2
    TEXT
    assert_equal expected, @test_tools.capture_result(@test_ls)
    @test_tools.remove_all_entries(entries)
  end

  def teardown
    @test_tools.cleanup
  end
end
