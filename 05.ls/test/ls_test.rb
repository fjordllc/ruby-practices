#!/usr/bin/env ruby

# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'
require 'tmpdir'
require 'tempfile'
require 'fileutils'
require 'stringio'
require 'debug'

class LsTest < Minitest::Test
  attr_writer :testdir

  def setup
    # テスト用ディレクトリ生成
    @testdir = Dir.mktmpdir
  end

  # ファイル生成
  def create_tmp_files(num = 1, is_ja: false)
    prefix = is_ja ? '日本語のファイル' : 'testfile'
    tmpfiles = []
    (1..num).each do |n|
      File.open("#{@testdir}/#{prefix}#{n}", 'w+') { |file| file.write('test') }
      tmpfiles << "#{prefix}#{n}"
    end
    tmpfiles.sort
  end

  # ディレクトリ生成
  def create_tmp_dirs(num = 1, is_ja: false)
    prefix = is_ja ? '日本語のディレクトリ' : 'testdir'
    (1..num).each do
      Dir.mktmpdir([prefix, num], tmpdir: @testdir)
    end
  end

  # テストディレクトリ削除（再帰的に全て削除）
  def cleanup_testdir
    FileUtils.remove_entry_secure @testdir
  end

  # テストディレクトリ内の削除
  def remove_all_entries(entries)
    entries.each do |entry|
      FileUtils.remove_entry_secure "#{@testdir}/#{entry}"
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

  def test_one_file
    files = create_tmp_files(1)
    test_ls = Ls.new(@testdir)
    assert_equal "testfile1\n", capture_result(test_ls)
    remove_all_entries(files)
  end

  def test_one_japanese_file
    files = create_tmp_files(1, is_ja: true)
    test_ls = Ls.new(@testdir)
    assert_equal "日本語のファイル1\n", capture_result(test_ls)
    remove_all_entries(files)
  end

  # def ListMixedEntried
  # end

  # def ListManyFiles
  # end

  def teardown
    cleanup_testdir
  end
end
