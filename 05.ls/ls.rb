#!/usr/bin/env ruby

require 'optparse'
require 'date'
require 'etc'

opt = OptionParser.new

params = {}

opt.on('-r') {|v| params[:r] = v }
opt.on('-l') {|v| params[:l] = v }
opt.on('-a') {|v| params[:a] = v }

opt.parse!(ARGV)

if ARGV.count == 0
end

WORD_LENGTH= 24

if params[:a]
  files = Dir.glob('*', File::FNM_DOTMATCH)
else
  files = Dir.glob('*')
end

if params[:r]
  files = files.sort.reverse
else
  files = files.sort
end

def ftype(octal_str)
  {
    '10' => 'p', # FIFO
    '20' => 'c', # Character device
    '40' => 'd', # Directory
    '60' => 'b', # Block device
    '100' => '-', # Regular file
    '120' => 'l', # Symbolic link
    '140' => 's' # Socket
  }[octal_str]
end

def permission(permission_str)
  {
    '1' => '--x',
    '2' => '-w-',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx',
  }[permission_str]
end

def ftype_and_permission(octal_str)
  permission = octal_str.slice!(-3, 3)

  print ftype(octal_str)
  print permission.split('').map { |d| permission(d) }.join
end


def time(time)
  if time.year == Time.now.year
    time.strftime('%_m %_d %H:%M')
  else
    time.strftime('%_m %_d  %Y')
  end
end


if params[:l]
  padding_hash = {
    nlink: 0,
    user: 0,
    group: 0,
    size: 0,
  }

  total_block_count = 0

  files.each do |f|
    fs = File.stat(f)

    # Set padding count
    padding_hash[:nlink] = fs.nlink.to_s.length if fs.nlink.to_s.length > padding_hash[:nlink]
    padding_hash[:user] = Etc.getpwuid(fs.uid).name.length if Etc.getpwuid(fs.uid).name.length > padding_hash[:user]
    padding_hash[:group] = Etc.getgrgid(fs.gid).name.length if Etc.getgrgid(fs.gid).name.length > padding_hash[:group]
    padding_hash[:size] = fs.size.to_s.length if fs.size.to_s.length > padding_hash[:size]

    # Reduce total blocks
    total_block_count += fs.blocks
  end

  puts "total #{total_block_count}"

  files.each do |file_name|
    fs = File.stat(file_name)

    # ファイルタイプ アクセス権 ハードリンク数 所有者名 グループ名 バイト数 更新日時（または更新年月日） ファイル名
    puts "#{ftype_and_permission(fs.mode.to_s(8))}  #{fs.nlink.to_s.rjust(padding_hash[:nlink])} #{Etc.getpwuid(fs.uid).name.rjust(padding_hash[:user])}  #{Etc.getgrgid(fs.gid).name.rjust(padding_hash[:group])}  #{fs.size.to_s.rjust(padding_hash[:size])} #{time(fs.mtime)} #{file_name}"
  end
else
  window_width = %x{ tput cols }.chomp.to_i

  cols =  window_width / WORD_LENGTH

  rows = (files.count.to_f / cols.to_f).ceil

  files = files.each_slice(rows).map do |list|
    if list.count != rows
      (rows - list.count).times do
        list << ''
      end
    end

    list
  end

  files.transpose.each do |files|
    puts files.map { |file| print file.ljust(WORD_LENGTH) }.join
  end
end
