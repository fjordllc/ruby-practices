#!/usr/bin/env ruby
# frozen_string_literal: true

dir_and_file_names = Dir.glob('*')
# 列数を定数に
NumberOfColumn = 3
# 配列の要素数取得、列数で割って行数を出す。
number_of_lines = dir_and_file_names.length / NumberOfColumn

# dir_and_file_nameがnumber_of_linesで割り切れる時とそうでない時で条件分岐。
# number_of_linesで割り切れる時はnumber_of_linesで、それ以外はnumber_of_linesで割る

if dir_and_file_names.length % number_of_lines == 0
  a = dir_and_file_names.each_slice(number_of_lines).to_a
  FORMAT = "%-20s"
  results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      # printf FORMAT, fed
    end
    puts "\n"
  end
else
  a = dir_and_file_names.each_slice(number_of_lines + 1).to_a
  FORMAT = "%-20s"
  results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      printf FORMAT, fed
    end
    puts # zipメソッドに関する
  end
end

require 'optparse'
opt = OptionParser.new
opt.on('-a') {
  all_dir_and_file_names = Dir.glob('*', File::FNM_DOTMATCH)

NumberOfColumn = 3
number_of_lines = all_dir_and_file_names.length / NumberOfColumn

if all_dir_and_file_names.length % number_of_lines == 0
  a = all_dir_and_file_names.each_slice(number_of_lines).to_a
  # FORMAT = "%-20s"
  results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      printf FORMAT, fed
    end
    puts "\n"
  end
else
  a = all_dir_and_file_names.each_slice(number_of_lines + 1).to_a
  # FORMAT = "%-20s"
  results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      printf FORMAT, fed
    end
    puts
  end
end
}


opt.on('-r') {
re_dir_and_file_names = Dir.glob('*').reverse
# p re_dir_and_file_names
# 列数を定数に
# NumberOfColumn = 3
# 配列の要素数取得、列数で割って行数を出す。
number_of_lines = re_dir_and_file_names.length / NumberOfColumn

# dir_and_file_nameがnumber_of_linesで割り切れる時とそうでない時で条件分岐。
# number_of_linesで割り切れる時はnumber_of_linesで、それ以外はnumber_of_linesで割る

if re_dir_and_file_names.length % number_of_lines == 0
  a = re_dir_and_file_names.each_slice(number_of_lines).to_a
  # FORMAT = '%-20s'
  results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      printf FORMAT, fed
    end
    puts "\n"
  end
else
  a = re_dir_and_file_names.each_slice(number_of_lines + 1).to_a
  RFORMAT = '%-20s'
  results = a[0].zip(a[1], a[2])
  results.each do |result|
    result.each do |fed|
      printf RFORMAT, fed
    end
    puts
  end
end
}
opt.parse!(ARGV)
