#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('l')

def file_check
  ARGV.each_with_index do |arg, i| # ファイルが存在しなかったら警告をしてそこで終わりにする
    if File.directory?(arg) == true || File.exist?(arg) == false
      puts "#{ARGV[i]}は存在しないファイルです"
      exit
    end
  end
end

def calc_lines(str)
  File.open(str).read.count("\n")  # 行数計算
end

def calc_words(str)
  File.open(str).read # 単語数計算
      .unpack('H*') # 16進数変換
      .join(' ')
      .gsub(/20|(0[9a])/, ' ')  # 半角空白へ置換
      .split(/\s+/)             # 分割
      .size
end

def stdin(options)
  if options['l']
    stdin_calc_l
  else stdin_calc
  end
end

def calc_bytes(str)
  File.stat(str).size # 容量計算
end

def stdin_calc
  inputs = $stdin.readlines # 標準入力時
  lcount = 0
  wcount = 0
  bcount = 0
  inputs.each_with_index do |input, _i| # コマンドライン引数
    lcount += input.count("\n") # 行数
    wcount += input.split(/\s/).count { |w| !w.empty? }
    bcount += input.bytesize
  end
  print lcount.to_s.rjust(8)
  print wcount.to_s.rjust(8)
  print bcount.to_s.rjust(8)
end

def stdin_calc_l
  inputs = $stdin.readlines # 標準入力
  lcount = 0
  inputs.each_with_index do |input, _i| # コマンドライン引数
    lcount += input.count("\n")  # 行数
  end
  print lcount.to_s.rjust(8)
end

if ARGV[0]
  file_check
  file_count = 0
  total_l = 0
  total_w = 0
  total_b = 0

  ARGV.each_with_index do |arg, _i|
    file_count += 1
    print calc_lines(arg).to_s.rjust(8)
    print calc_words(arg).to_s.rjust(8) unless options
    print calc_bytes(arg).to_s.rjust(8) unless options
    puts " #{arg}"
    total_l += calc_lines(arg)
    total_w += calc_words(arg) unless options
    total_b += calc_bytes(arg) unless options
  end
  if file_count > 1
    print total_l.to_s.rjust(8)
    print total_w.to_s.rjust(8) unless options
    print total_b.to_s.rjust(8) unless options
    print ' total'
  end

else
  stdin(options)
end

puts
