#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'

# プログラム内で使用する定数の定義
FORMAT = '%-20s'
L_FORMAT = "%s%-6s %3s %-8s %-8s %6s %7s %-16s \n"
NUMBER_COLUMNS = 3

def main
  options = ARGV.getopts('a', 'r', 'l')
  dir_and_file_names = get_dir_and_file_name(options)
  if options['l']
    output_with_option_l(dir_and_file_names)
  else
    output_without_option_l(dir_and_file_names)
  end
end

# 表示するデータ取得
def get_dir_and_file_name(options)
  result = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
  options['r'] ? result.reverse : result
end

# -lオプション時の出力
def calc_total_number(dir_and_file_names)
  total_number = dir_and_file_names.sum do |dir_and_file_name|
    ls_l_stat = File::Stat.new(dir_and_file_name)
    ls_l_stat.blocks
  end
  puts "total #{total_number}"
end

def output_with_option_l(dir_and_file_names)
  calc_total_number(dir_and_file_names)

  dir_and_file_names.each do |dir_and_file_name|
    ls_l_stat = File.lstat(dir_and_file_name)

    converted_filetype = convert_filetypes(ls_l_stat)
    converted_permission = convert_permissions(ls_l_stat)
    symbolic_link = ls_l_stat.nlink
    user_name = Etc.getpwuid(ls_l_stat.uid).name
    group_name = Etc.getgrgid(ls_l_stat.gid).name
    file_size = ls_l_stat.size
    time_stamp = cal_time_stamp(ls_l_stat)
    filename_for_format = File.basename(dir_and_file_name)

    printf L_FORMAT, converted_filetype, converted_permission, symbolic_link, user_name, group_name,
           file_size, time_stamp, filename_for_format
  end
end

def convert_filetypes(ls_l_stat)
  { 'link' => 'l', 'file' => '-', 'directory' => 'd' }[ls_l_stat.ftype]
end

def convert_permissions(ls_l_stat)
  permission_hash = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' =>
    'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }
  m = ls_l_stat.mode.to_s(8)
  permission_hash[m[-3]] + permission_hash[m[-2]] + permission_hash[m[-1]]
end

def cal_time_stamp(ls_l_stat)
  present_time = Time.now
  if (present_time - ls_l_stat.mtime) < 60 * 60 * 24 * 180 # 半年を30*6日としている
    ls_l_stat.mtime.strftime('%_m %_d %H:%M')
  else
    ls_l_stat.mtime.strftime('%_m %_d %_5Y')
  end
end

# -lオプションがない時の出力
def output_without_option_l(dir_and_file_names)
  number_of_lines = dir_and_file_names.length / NUMBER_COLUMNS
  array_for_outputs = if (dir_and_file_names.length % NUMBER_COLUMNS).zero?
                        dir_and_file_names.each_slice(number_of_lines).to_a
                      else
                        dir_and_file_names.each_slice(number_of_lines + 1).to_a
                      end
  convert_matrix(array_for_outputs)
end

def convert_matrix(array_for_outputs)
  array_for_outputs.map! do |array_for_output|
    array_for_output.values_at(0..array_for_outputs.map(&:size).max - 1)
  end
  array_for_outputs.transpose.each do |row|
    row.each { |fed| printf FORMAT, fed }
    puts
  end
end

main
