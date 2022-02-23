# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'
require 'stringio'
require 'debug'

class TestTools
  attr_reader :test_dir

  def initialize
    @test_dir = Dir.mktmpdir
    @ascii_file_basename = 'test_file'
    @ja_file_basename = '日本語のファイル'
    @ascii_dir_basename = 'test_dir'
    @ja_dir_basename = '日本語のディレクトリ'
  end

  def create_tmp_files(num_of_files, sub_dir: nil, is_ja: false, is_hidden: false)
    raise ArgumentError, "テストディレクトリ外にファイルは作成できません: #{sub_dir}" unless include?(sub_dir) || sub_dir.nil?
    raise Errno::ENOENT, "テストディレクトリ内にディレクトリが存在しません: #{sub_dir}" unless sub_dir.nil? || File.directory?("#{@test_dir}/#{sub_dir}")

    prefix = is_hidden ? '.' : ''
    basename = is_ja ? @ja_file_basename : @ascii_file_basename
    create_tmp_files_common(num_of_files, "#{prefix}#{basename}", sub_dir: sub_dir)
  end

  def create_tmp_files_common(num_of_files, basename, sub_dir: nil)
    return unless num_of_files.positive?

    (1..num_of_files).to_a.map do |n|
      file_name = sub_dir.nil? ? "#{basename}#{n}" : "#{sub_dir}/#{basename}#{n}"
      File.open("#{@test_dir}/#{file_name}", 'w+') {}
      file_name
    end
  end

  def create_tmp_dirs(num_of_dirs, sub_dir: nil, is_ja: false, is_hidden: false)
    raise ArgumentError, "テストディレクトリ外にファイルは作成できません: #{sub_dir}}" unless include?(sub_dir) || sub_dir.nil?
    raise Errno::ENOENT, "テストディレクトリ内にディレクトリが存在しません: #{sub_dir}" unless sub_dir.nil? || File.directory?("#{@test_dir}/#{sub_dir}")

    prefix = is_hidden ? '.' : ''
    basename = is_ja ? @ja_dir_basename : @ascii_dir_basename
    create_tmp_dirs_common(num_of_dirs, "#{prefix}#{basename}", sub_dir: sub_dir)
  end

  def create_tmp_dirs_common(num_of_dirs, basename, sub_dir: nil)
    return unless num_of_dirs.positive?

    (1..num_of_dirs).map do |n|
      dir_name = sub_dir.nil? ? "#{basename}#{n}" : "#{sub_dir}/#{basename}#{n}"
      Dir.mkdir("#{@test_dir}/#{dir_name}")
      dir_name
    end
  end

  def include?(dir_name_input)
    # rootで指定したディレクトリにinputで指定したディレクトリが含まれるか（存在するかは関係なし）
    return true if dir_name_input.nil?

    input = File.absolute_path(dir_name_input, @test_dir)
    input.match(/^#{File.absolute_path(@test_dir)}/)
  end

  # テストディレクトリ削除（再帰的に全て削除）
  def cleanup
    FileUtils.remove_entry_secure @test_dir
  end

  # テストディレクトリ内のファイル・ディレクトリ削除
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
