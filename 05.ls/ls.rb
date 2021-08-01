#!/usr/bin/env ruby
# frozen_string_literal: true
require 'optparse'
require 'etc'

options = ARGV.getopts('a', 'r', 'l')

FORMAT = '%-20s'
LFORMAT = "%s%-6s %3s %-8s %-8s %6s %7s %-16s \n"
NumberOfColumn = 3

dir_and_file_names =
  if options['a'] && options['r']
    Dir.glob('*', File::FNM_DOTMATCH).reverse
  elsif options['a']
    Dir.glob('*', File::FNM_DOTMATCH)
  elsif options['r']
    Dir.glob('*').reverse
  else
    Dir.glob('*')
  end

if options['l']
  # LFORMAT = "%s%-6s %3s %-8s %-8s %6s %7s %-16s \n"
  file_number = dir_and_file_names.length

  array_for_blocks = []
  file_number.times do |n|
    ls_l_stat = File::Stat.new(dir_and_file_names[n])
    b = ls_l_stat.blocks
    array_for_blocks << b
  end
  total_number = array_for_blocks.sum
  puts "total #{total_number}"

  a = Time.now
  file_number.times do |n|
    ls_l_stat = File.lstat(dir_and_file_names[n])
    ft = ls_l_stat.ftype
    case ft
    when 'link'
      ft.replace 'l'
    when 'file'
      ft.replace '-'
    when 'directory'
      ft.replace 'd'
    end

    m = ls_l_stat.mode.to_s(8) # 8進数に変換
    convert_pamissions = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--',
                           '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }
    converted_pamission = convert_pamissions[m[-3]] + convert_pamissions[m[-2]] + convert_pamissions[m[-1]]

    nl = ls_l_stat.nlink
    u_name = Etc.getpwuid(ls_l_stat.uid).name
    g_name = Etc.getgrgid(ls_l_stat.gid).name
    s = ls_l_stat.size
    mt = if (a.month + 6) > ls_l_stat.mtime.month && (a.month - 6) < ls_l_stat.mtime.month
           ls_l_stat.mtime.strftime('%_m %_d %H:%M')
         else
           ls_l_stat.mtime.strftime('%_m %_d %_5Y')
         end
    file_name = dir_and_file_names[n]
    f = File.basename(file_name)
    printf LFORMAT, ft, converted_pamission, nl, u_name, g_name, s, mt, f
  end

else
  number_of_lines = dir_and_file_names.length / NumberOfColumn
  if dir_and_file_names.length % number_of_lines == 0
    a = dir_and_file_names.each_slice(number_of_lines).to_a
    results = a[0].zip(a[1], a[2])
    results.each do |result|
      result.each do |fed|
        printf FORMAT, fed
      end
      puts "\n"
    end
  else
    a = dir_and_file_names.each_slice(number_of_lines + 1).to_a
    results = a[0].zip(a[1], a[2])
    results.each do |result|
      result.each do |fed|
        printf FORMAT, fed
      end
      puts
    end
  end
end
