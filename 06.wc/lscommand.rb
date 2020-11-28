#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'
require 'tmpdir'

options = ARGV.getopts('a', 'l', 'r')

files = [] # ファイル名を入れていく配列 aオプションがつくかつかないかで変わる

if options['a'] == false # aオプションなし
  Dir.foreach('.') do |item|
    next if item == '.' || item == '..' || item.start_with?('.')

    files.push(item)
  end
else # aオプションあり
  Dir.foreach('.') do |item|
    files.push(item)
  end
end

files.sort! # アルファベット順にする

files.reverse! if options['r'] == true # rオプションがついてたら逆に並び替え
blocks = 0 # ブロック数を合計する、total
if options['l'] == true
  files.each do |file|
    stat = File.stat(file)
    blocks += stat.blocks.to_i
  end
  puts "total #{blocks}" # ブロック数
end

files.each do |file| # ファイルごとの処理
  stat = File.stat(file)
  if options['l'] == true # lオプションあり
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
    puts file.to_s  # ファイル名
  else
    print file.to_s.ljust(16)

  end
end

puts ''
