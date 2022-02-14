#!/usr/bin/env ruby

# frozen_string_literal: true

require 'minitest/autorun'
require 'tmpdir'
require 'tempfile'
require 'fileutils'
require 'debug'

COMMAND = '../lib/ls.rb'

class LsTest < Minitest::Test
  attr_reader :testdir

  def setup
    # テスト用ディレクトリ生成
    @testdir = Dir.mktmpdir
  end

  # ファイル生成
  def create_tmp_files(num = 1, is_ja: false)
    prefix = is_ja ? '日本語のファイル' : 'testfile'
    tmpfiles = []
    (1..num).each do |n|
      tmpfiles << Tempfile.create([prefix, n.to_s], tmpdir: @testdir)
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

  # ファイル・ディレクトリ削除（再帰的に全て削除）
  def cleanup_testdir
    FileUtils.remove_entries_secure(@testdir)
  end

  # ディレクトリ削除
  def cleanup_dirs(dirs)
    dirs.each { |dir| Dir.unlink(dir) }
  end

  def test_list_one_file
    files = create_tmp_files(1)
    binding.b
    output = `#{COMMAND} #{@testdir}`
    assert_equal output, file.basename.to_s
  end

  # def ListOneDir
  # end

  # def ListMixedEntried
  # end

  # def ListManyFiles
  # end

  def teardown
    # クリーンアップ
    cleanup_testdir
    Dir.unlink(@testdir)
  end
end
