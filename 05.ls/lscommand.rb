#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'
require 'tmpdir'

options = ARGV.getopts('a', 'l', 'r')
files = []
blocks = 0

def all_files(files)
  Dir.foreach('.') do |item|
    files.push(item)
  end
end

def not_a_files(files)
  Dir.foreach('.') do |item|
    next if item == '.' || item == '..' || item.start_with?('.') # 隠しファイルを排除する

    files.push(item)
  end
end

def format_3_arrays(files)
  i = 0
  while i < files.sort.size % 3
    i += 1
    files << ''
  end
  number_of_files = files.size / 3
  files.each_slice(number_of_files).to_a
end

def transpose_files(files)
  files = files.transpose
  files.each do |array_file|
    array_file.each do |file|
      print file.ljust(20)
    end
    puts
  end
end

def sort_files(files)
  files.sort
end

def sort_files_reverse(files)
  files.sort.reverse
end

if options['a']
  all_files(files)
else
  not_a_files(files)
end

files = if options['r']
          sort_files_reverse(files)
        else
          sort_files(files)
        end

def option_l_total(files, blocks)
  files.each do |file|
    stat = File.stat(file)
    blocks += stat.blocks.to_i
  end
  puts "total #{blocks}" # ブロック数
end

def options_l(files)
  files.each do |file| # ファイルごとの処理
    stat = File.stat(file)
    ftype = File.ftype(file) # ファイルタイプ
    ftype_table = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }
    print ftype_table[ftype]
    int_permittion = stat.mode.to_s(8).to_i % 1000 # permissionを８進数にする
    permission_table = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
    print permission_table[int_permittion.digits[2]]
    print permission_table[int_permittion.digits[1]]
    print "#{permission_table[int_permittion.digits[0]]} "
    print stat.nlink.to_s.rjust(2) # ハードリンクの数
    print "\s#{Etc.getpwuid(stat.uid).name} ".rjust(12) # ユーザー名
    print Etc.getgrgid(stat.gid).name.to_s.rjust(6) # グループ名
    print stat.size.to_s.rjust(5) # size
    mtime = stat.mtime # 更新日時
    print "\s#{mtime.strftime('%m %d %H:%M')} "
    puts file.to_s # ファイル名
  end
end

if options['l']
  option_l_total(files, blocks)
  options_l(files)
else
  files = format_3_arrays(files)
  transpose_files(files)
end
