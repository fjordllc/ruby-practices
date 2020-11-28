#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')

def argv
  ARGV # 引数で ARGV の中身を 渡すようにする
end

def argv_check
  !ARGV[0].nil? # nilだったら標準入力をみたいのでfalseにする
end

def file_check(isfiles)
  isfiles.each_with_index do |arg, i| # ファイルが存在しなかったら警告をしてそこで終わりにする
    if File.directory?(arg) == true || File.exist?(arg) == false
      puts "#{isfiles[i]}は存在しないファイルです"
      exit
    end
  end
end

def openfiles(str)
  File.open(str).read
end

def calc_lines(str)
  str.count("\n")
end

def calc_words(str)
  str.split(/\s/).count { |w| !w.empty? }
end

def calc_bytes(str)
  str.bytesize
end

def rjust(target_string)
  target_string.rjust(8)
end

def stdin_calc(option_l)
  inputs = $stdin.readlines # 標準入力時
  print   rjust(calc_lines(inputs.join).to_s)
  print   rjust(calc_words(inputs.join).to_s) unless option_l['l']
  print   rjust(calc_bytes(inputs.join).to_s) unless option_l['l']
end

if argv_check
  file_check(argv)
  file_count = 0
  total_l = 0
  total_w = 0
  total_b = 0

  argv.each_with_index do |arg, _i|
    file_count += 1
    str = openfiles(arg)
    print rjust(calc_lines(str).to_s)
    print rjust(calc_words(str).to_s) unless options['l']
    print rjust(calc_bytes(str).to_s) unless options['l']
    print " #{arg}"
    total_l += calc_lines(str)
    total_w += calc_words(str) unless options['l']
    total_b += calc_bytes(str) unless options['l']
    puts
  end
  if file_count > 1
    print rjust(total_l.to_s)
    print rjust(total_w.to_s) unless options['l']
    print rjust(total_b.to_s) unless options['l']
    print ' total'
  end

else
  stdin_calc(options)
end

puts
