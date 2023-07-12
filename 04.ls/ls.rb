# frozen_string_literal: true

require 'date'
require 'optparse'

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

a_option_flag = 0

# コマンドライン引数の取得
OptionParser.new do |o|
  o.on('-a') { a_option_flag = File::FNM_DOTMATCH }
  # TODO:	後のプラクティスで実装
  o.on('-r') {}
  o.on('-l') {}

  o.parse!(ARGV) # パス指定オプションが入る
rescue OptionParser::InvalidOption => e
  puts e.message
  exit
end

path_list = ARGV[0] ? ARGV : ['.']

path_list.each do |path|
  if File.exist?(path)
    if File.directory?(path)
      file_dir_list = Dir.glob('*', flags: a_option_flag, base: path).map { |m| File.basename(m) }
      ls_display_matrix(file_dir_list, UPPER_LIMIT_COLUMN_COUNT, COLUMN_PADDING_SIZE)
    else
      puts File.basename(path)
    end
    puts
  else
    puts "ls: cannot access '#{path}': No such file or directory"
  end
end
