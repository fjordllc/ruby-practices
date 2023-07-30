# frozen_string_literal: true

require 'date'
require 'optparse'
require 'etc'

UPPER_LIMIT_COLUMN_COUNT = 3 # > 0

# 列ごとの最大文字列長　に加えるスペース数。
COLUMN_PADDING_SIZE = 2 # > 0

class String
  # 見た目上の幅を返すように定義
  def exact_size
    each_char.map { |c| c.bytesize == 1 ? 1 : 2 }.sum
  end

  # マルチバイト文字を正しく左詰めできるように
  def mb_ljust(width, padding = ' ')
    padding_size = [0, width - exact_size].max
    self + padding * padding_size
  end
end

class File::Stat
  def filetype
    {
      'file' => '-',
      'directory' => 'd',
      'characterSpecial' => 'c',
      'blockSpecial' => 'b',
      'fifo' => 'p',
      'link' => 'l',
      'socket' => 's',
      'unknown' => '?'
    }[ftype]
  end

  def mode_formatted
    modes = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx']
    mode.to_s(8)[-3..].chars.map { |num| modes[num.to_i] }.join
  end
end

def calculate_num_of_row(num_of_column, num_of_display)
  return 1 if num_of_column > num_of_display

  num_of_display / num_of_column + 1
end

def ls_display_matrix(file_dir_list, upper_limit_column_count, column_padding_size)
  num_of_row = calculate_num_of_row(upper_limit_column_count, file_dir_list.size)

  # 表示内容を表す行列の転置verを作成
  display_matrix_transposed = file_dir_list.each_slice(num_of_row).to_a

  # 列ごとの表示幅を計算
  column_width_list = display_matrix_transposed.map { |n| n.map(&:exact_size).max + column_padding_size }

  # 目的 : 配列最後尾の長さを揃えるために 自己代入
  # 背景 : 仕様上、右端columnのみ長さ不一致の可能性がある
  #        transposeメソッドは配列の長さが不揃いだとエラーになるため実装。
  display_matrix_transposed[-1][num_of_row - 1] ||= nil

  display_matrix_transposed.transpose.each do |line|
    row_string = line.compact.each_with_index.inject('') do |result, (item, idx)|
      result + item.mb_ljust(column_width_list[idx])
    end
    puts row_string
  end
end

def make_files_info(file_dir_list, path)
  total_blocks = 0
  list = file_dir_list.map do |n|
    fs = File::Stat.new("#{path}/#{n}")
    total_blocks += fs.blocks
    {
      mode: fs.filetype + fs.mode_formatted,
      num_link: fs.nlink,
      owner: Etc.getpwuid(fs.uid).name,
      group: Etc.getgrgid(fs.gid).name,
      file_size: fs.size,
      time: format_time_by_modification(fs.mtime),
      path: name_with_symlink_target_if_exists(path, n)
    }
  end
  [total_blocks, list]
end

def ls_display_long_format(hash_list, widths)
  hash_list.each do |info_hash|
    info_hash.each do |key, value|
      value = value.to_s.rjust(widths[key], ' ') if widths.key?(key)
      print "#{value} "
    end
    puts
  end
end

def calculate_max_widths(hash_list)
  {
    num_link: hash_list.max_by { |hash| hash[:num_link].to_s.length }[:num_link].to_s.length,
    owner: hash_list.max_by { |hash| hash[:owner].length }[:owner].length,
    group: hash_list.max_by { |hash| hash[:group].length }[:group].length,
    file_size: hash_list.max_by { |hash| hash[:file_size].to_s.length }[:file_size].to_s.length
  }
end

def format_time_by_modification(time)
  # 現在日時から6か月前の日時を計算
  six_months_ago = Time.now - (60 * 60 * 24 * 30 * 6)

  # ファイルの最終更新日時が6か月前よりも後であれば
  return time.strftime('%b %e %R') if time > six_months_ago

  time.strftime('%b %e  %G')
end

def name_with_symlink_target_if_exists(path, name)
  return name unless File.symlink?("#{path}/#{name}")

  "#{name} -> #{File.readlink("#{path}/#{name}")}"
end

a_option = false
r_option = false
l_option = false

# コマンドライン引数の取得
OptionParser.new do |o|
  o.on('-a') { a_option = true }
  o.on('-r') { r_option = true }
  o.on('-l') { l_option = true }
  
  o.parse!(ARGV) # パス指定オプションが入る
rescue OptionParser::InvalidOption => e
  puts e.message
  exit
end

path_list = ARGV[0] ? ARGV : ['.']

path_list.each do |path|
  puts "ls: cannot access '#{path}': No such file or directory" unless File.exist?(path)
  puts File.basename(path) unless File.directory?(path)

  file_dir_list =
    if a_option
      Dir.glob('*', flags: File::FNM_DOTMATCH, base: path).map { |m| File.basename(m) }
    else
      Dir.glob('*', base: path).map { |m| File.basename(m) }
    end
  file_dir_list.reverse! if r_option
  if l_option
    total_blocks, files_info = make_files_info(file_dir_list, path)
    puts "total #{total_blocks}"
    ls_display_long_format(files_info, calculate_max_widths(files_info))
  else
    ls_display_matrix(file_dir_list, UPPER_LIMIT_COLUMN_COUNT, COLUMN_PADDING_SIZE)
  end
  puts
end
