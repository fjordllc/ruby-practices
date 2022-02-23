#!/usr/bin/env ruby

# frozen_string_literal: true

require 'minitest/autorun'
require_relative './test_tools'

class TestToolsBasicTest < Minitest::Test
  def setup
    @test_tools = TestTools.new
  end

  def test_create_and_destroy_testdir
    assert File.directory?(@test_tools.test_dir)
    @test_tools.cleanup
    refute File.exist?(@test_tools.test_dir)
  end

  def test_collect_include?
    assert @test_tools.include?('./test1')
    assert @test_tools.include?('test1')
    assert @test_tools.include?("#{@test_tools.test_dir}/test1/test2")
    assert @test_tools.include?(@test_tools.test_dir)
  end

  def test_invalid_include?
    refute @test_tools.include?('../test1')
    refute @test_tools.include?('/Users')
    refute @test_tools.include?("#{@test_tools.test_dir}/../test1/test2")
  end

  def test_remove_file
    File.open("#{@test_tools.test_dir}/testfile", 'w') {}
    @test_tools.remove_entries(['testfile'])
    refute File.exist?("#{@test_tools.test_dir}/testfile")
  end

  def test_remove_dir
    Dir.mkdir("#{@test_tools.test_dir}/testdir")
    @test_tools.remove_entries(['testdir'])
    refute File.exist?("#{@test_tools.test_dir}/testdir")
  end

  def teardown
    @test_tools.cleanup if File.exist?(@test_tools.test_dir)
  end
end

class TestToolsCreateFileTest < Minitest::Test
  def setup
    @test_tools = TestTools.new
  end

  def test_create_ascii_file
    @test_tools.create_tmp_files(1)
    assert File.file?("#{@test_tools.test_dir}/test_file1")
  end

  def test_create_ja_file
    @test_tools.create_tmp_files(1, is_ja: true)
    assert File.exist?("#{@test_tools.test_dir}/日本語のファイル1")
  end

  def test_create_hidden_ascii_file
    @test_tools.create_tmp_files(1, is_hidden: true)
    assert File.exist?("#{@test_tools.test_dir}/.test_file1")
  end

  def test_create_hidden_ja_file
    @test_tools.create_tmp_files(1, is_ja: true, is_hidden: true)
    assert File.exist?("#{@test_tools.test_dir}/.日本語のファイル1")
  end

  def test_create_ascii_files
    num_of_files = 3
    @test_tools.create_tmp_files(num_of_files)
    (1..num_of_files).each do |n|
      assert File.exist?("#{@test_tools.test_dir}/test_file#{n}")
    end
    refute File.exist?("#{@test_tools.test_dir}/test_file4")
  end

  def test_create_ja_files
    num_of_files = 3
    @test_tools.create_tmp_files(num_of_files, is_ja: true)
    (1..num_of_files).each do |n|
      assert File.exist?("#{@test_tools.test_dir}/日本語のファイル#{n}")
    end
    refute File.exist?("#{@test_tools.test_dir}/日本語のファイル4")
  end

  def teardown
    @test_tools.cleanup
  end
end

class TestToolsCreateDirTest < Minitest::Test
  def setup
    @test_tools = TestTools.new
  end

  def test_create_ascii_dir
    @test_tools.create_tmp_dirs(1)
    assert File.directory?("#{@test_tools.test_dir}/test_dir1")
  end

  def test_create_ja_dir
    @test_tools.create_tmp_dirs(1, is_ja: true)
    assert File.directory?("#{@test_tools.test_dir}/日本語のディレクトリ1")
  end

  def test_create_ascii_dirs
    num_of_dirs = 3
    @test_tools.create_tmp_dirs(num_of_dirs)
    (1..num_of_dirs).each do |n|
      assert File.directory?("#{@test_tools.test_dir}/test_dir#{n}")
    end
    refute File.directory?("#{@test_tools.test_dir}/test_dir4")
  end

  def test_create_ja_dirs
    num_of_dirs = 3
    @test_tools.create_tmp_dirs(num_of_dirs, is_ja: true)
    (1..num_of_dirs).each do |n|
      assert File.directory?("#{@test_tools.test_dir}/日本語のディレクトリ#{n}")
    end
    refute File.directory?("#{@test_tools.test_dir}/日本語のディレクトリ4")
  end

  def test_create_hidden_ascii_dir
    @test_tools.create_tmp_dirs(1, is_hidden: true)
    assert File.directory?("#{@test_tools.test_dir}/.test_dir1")
  end

  def test_create_hidden_ja_dir
    @test_tools.create_tmp_dirs(1, is_ja: true, is_hidden: true)
    assert File.directory?("#{@test_tools.test_dir}/.日本語のディレクトリ1")
  end

  def teardown
    @test_tools.cleanup
  end
end

class TestToolsCreateFileInSubDirTest < Minitest::Test
  def setup
    @test_tools = TestTools.new
  end

  def test_create_ascii_file_in_subdir
    @test_tools.create_tmp_dirs(1)
    @test_tools.create_tmp_files(1, sub_dir: 'test_dir1')
    assert File.file?("#{@test_tools.test_dir}/test_dir1/test_file1")
  end

  def test_create_ja_file_in_subdir
    @test_tools.create_tmp_dirs(1)
    @test_tools.create_tmp_files(1, sub_dir: 'test_dir1', is_ja: true)
    assert File.file?("#{@test_tools.test_dir}/test_dir1/日本語のファイル1")
  end

  def test_create_hidden_ascii_file_in_subdir
    @test_tools.create_tmp_dirs(1)
    @test_tools.create_tmp_files(1, sub_dir: 'test_dir1', is_hidden: true)
    assert File.file?("#{@test_tools.test_dir}/test_dir1/.test_file1")
  end

  def test_create_hidden_ja_file_in_subdir
    @test_tools.create_tmp_dirs(1)
    @test_tools.create_tmp_files(1, sub_dir: 'test_dir1', is_ja: true, is_hidden: true)
    assert File.file?("#{@test_tools.test_dir}/test_dir1/.日本語のファイル1")
  end

  def test_create_ascii_files_in_subdir
    @test_tools.create_tmp_dirs(1)
    num_of_files = 3
    @test_tools.create_tmp_files(num_of_files, sub_dir: 'test_dir1')
    (1..num_of_files).each do |n|
      assert File.file?("#{@test_tools.test_dir}/test_dir1/test_file#{n}")
    end
    refute File.file?("#{@test_tools.test_dir}/test_dir1/test_file4")
  end

  def test_create_ja_files_in_subdir
    @test_tools.create_tmp_dirs(1)
    num_of_files = 3
    @test_tools.create_tmp_files(num_of_files, sub_dir: 'test_dir1', is_ja: true)
    (1..num_of_files).each do |n|
      assert File.file?("#{@test_tools.test_dir}/test_dir1/日本語のファイル#{n}")
    end
    refute File.file?("#{@test_tools.test_dir}/test_dir1/日本語のファイル4")
  end

  def test_create_file_in_invalid_subdir
    e1 = assert_raises ArgumentError do
      @test_tools.create_tmp_files(1, sub_dir: '../invalid_dir')
    end
    assert_equal 'テストディレクトリ外にファイルは作成できません: ../invalid_dir', e1.message

    e2 = assert_raises ArgumentError do
      @test_tools.create_tmp_files(1, sub_dir: '/tmp/invalid_dir')
    end
    assert_equal 'テストディレクトリ外にファイルは作成できません: /tmp/invalid_dir', e2.message
  end

  def test_create_file_in_nonexistent_subdir
    e = assert_raises Errno::ENOENT do
      @test_tools.create_tmp_files(1, sub_dir: 'nonexistent_dir')
    end
    assert_equal 'No such file or directory - テストディレクトリ内にディレクトリが存在しません: nonexistent_dir', e.message
  end

  def teardown
    @test_tools.cleanup
  end
end

class TestToolsCreateDirsInSubDirTest < Minitest::Test
  def setup
    @test_tools = TestTools.new
  end

  def test_create_ascii_dir_in_subdir
    @test_tools.create_tmp_dirs(1)
    @test_tools.create_tmp_dirs(1, sub_dir: 'test_dir1')
    assert File.exist?("#{@test_tools.test_dir}/test_dir1/test_dir1")
  end

  def test_create_ja_file_in_subdir
    @test_tools.create_tmp_dirs(1)
    @test_tools.create_tmp_dirs(1, sub_dir: 'test_dir1', is_ja: true)
    assert File.exist?("#{@test_tools.test_dir}/test_dir1/日本語のディレクトリ1")
  end

  def test_create_ascii_dirs_in_subdir
    @test_tools.create_tmp_dirs(1)
    num_of_dirs = 3
    @test_tools.create_tmp_dirs(num_of_dirs, sub_dir: 'test_dir1')
    (1..num_of_dirs).each do |n|
      assert File.exist?("#{@test_tools.test_dir}/test_dir1/test_dir#{n}")
    end
    refute File.exist?("#{@test_tools.test_dir}/test_dir1/test_dir4")
  end

  def test_create_ja_dirs_in_subdir
    @test_tools.create_tmp_dirs(1)
    num_of_dirs = 3
    @test_tools.create_tmp_dirs(num_of_dirs, sub_dir: 'test_dir1', is_ja: true)
    (1..num_of_dirs).each do |n|
      assert File.directory?("#{@test_tools.test_dir}/test_dir1/日本語のディレクトリ#{n}")
    end
    refute File.exist?("#{@test_tools.test_dir}/test_dir1/日本語のディレクトリ4")
  end

  def teardown
    @test_tools.cleanup
  end
end
