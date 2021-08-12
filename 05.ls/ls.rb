#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'
options = ARGV.getopts('a', 'r', 'l')

# プログラム内で使用する定数の定義
FORMAT = '%-20s'
L_FORMAT = "%s%-6s %3s %-8s %-8s %6s %7s %-16s \n"
NUMBER_COLUMNS = 3

# 表示するデータ取得に関するプログラム
def get_dir_and_file_name(options)
  if options['a']
    Dir.glob('*', File::FNM_DOTMATCH)
  else
    Dir.glob('*')
  end
end

def reverse_dir_and_file_name(options)
  result = get_dir_and_file_name(options)
  return result unless options['r']

  result.reverse
end

dir_and_file_names = reverse_dir_and_file_name(options)

# 出力に関するプログラム
if options['l'] # -lオプション時の出力
  array_for_blocks = dir_and_file_names.map do |dir_and_file_name|
    ls_l_stat = File::Stat.new(dir_and_file_name)
    ls_l_stat.blocks
  end
  total_number = array_for_blocks.sum
  puts "total #{total_number}"

  dir_and_file_names.each do |dir_and_file_name|
    ls_l_stat = File.lstat(dir_and_file_name)
    convert_filetypes = { 'link' => 'l', 'file' => '-', 'directory' => 'd' }
    converted_filetype = convert_filetypes[ls_l_stat.ftype]
    m = ls_l_stat.mode.to_s(8)
    convert_permissions = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' =>
      'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }
    converted_permission = convert_permissions[m[-3]] + convert_permissions[m[-2]] + convert_permissions[m[-1]]
    symbolic_link = ls_l_stat.nlink
    user_name = Etc.getpwuid(ls_l_stat.uid).name
    group_name = Etc.getgrgid(ls_l_stat.gid).name
    file_size = ls_l_stat.size
    present_time = Time.now # time_stampに関わる
    time_stamp = if (present_time - ls_l_stat.mtime) < 60 * 60 * 24 * 180 # 半年を30*6日としている
                   ls_l_stat.mtime.strftime('%_m %_d %H:%M')
                 else
                   ls_l_stat.mtime.strftime('%_m %_d %_5Y')
                 end
    file_name = dir_and_file_name
    filename_for_format = File.basename(file_name)
    printf L_FORMAT, converted_filetype, converted_permission, symbolic_link, user_name, group_name,
           file_size, time_stamp, filename_for_format
  end
else
  # -lオプションがない時の出力
  number_of_lines = dir_and_file_names.length / NUMBER_COLUMNS
  number_of_lines += 1 unless (dir_and_file_names.length % number_of_lines).zero?
  array_for_outputs = dir_and_file_names.each_slice(number_of_lines).to_a
  number_of_elements = array_for_outputs.map(&:size)

  array_for_outputs.map! { |array_for_output| array_for_output.values_at(0..(number_of_elements.max - 1)) }
  array_for_outputs.transpose.each do |row|
    row.each do |fed|
      printf FORMAT, fed
    end
    puts
  end
end
