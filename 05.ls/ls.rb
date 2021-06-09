#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require 'date'
require 'etc'

WORD_LENGTH = 24

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
    '7' => 'rwx'
  }[permission_str]
end

def ftype_and_permission(octal_str)
  permission = octal_str.slice!(-3, 3)

  print ftype(octal_str)
  print permission.split('').map { |d| permission(d) }.join
end

def user_name(uid)
  Etc.getpwuid(uid).name
end

def group_name(gid)
  Etc.getgrgid(gid).name
end

def time(time)
  if time.year == Time.now.year
    time.strftime('%_m %_d %H:%M')
  else
    time.strftime('%_m %_d  %Y')
  end
end

# Implements

opt = OptionParser.new

params = {}

opt.on('-r') { |v| params[:r] = v }
opt.on('-l') { |v| params[:l] = v }
opt.on('-a') { |v| params[:a] = v }

opt.parse!(ARGV)

files = if params[:a]
          Dir.glob('*', File::FNM_DOTMATCH)
        else
          Dir.glob('*')
        end

files = if params[:r]
          files.sort.reverse
        else
          files.sort
        end

if params[:l]
  padding_hash = {
    nlink: 0,
    user: 0,
    group: 0,
    size: 0
  }

  total_block_count = 0

  files.each do |file_name|
    fs = File.stat(file_name)

    # Set padding count
    padding_hash[:nlink] = fs.nlink.to_s.length if fs.nlink.to_s.length > padding_hash[:nlink]
    padding_hash[:user] = user_name(fs.uid).length if user_name(fs.uid).length > padding_hash[:user]
    padding_hash[:group] = group_name(fs.gid).length if group_name(fs.gid).length > padding_hash[:group]
    padding_hash[:size] = fs.size.to_s.length if fs.size.to_s.length > padding_hash[:size]

    # Reduce total blocks
    total_block_count += fs.blocks
  end

  puts "total #{total_block_count}"

  files.each do |file_name|
    fs = File.stat(file_name)

    result = "#{ftype_and_permission(fs.mode.to_s(8))}  " # ファイルタイプ アクセス権
    result += "#{fs.nlink.to_s.rjust(padding_hash[:nlink])} " # ハードリンク数
    result += "#{user_name(fs.uid).rjust(padding_hash[:user])}  " # 所有者名
    result += "#{group_name(fs.gid).rjust(padding_hash[:group])}  " # グループ名
    result += "#{fs.size.to_s.rjust(padding_hash[:size])} " # バイト数
    result += "#{time(fs.mtime)} #{file_name}" # 更新日時（または更新年月日） ファイル名

    puts result
  end
else
  window_width = `tput cols`.chomp.to_i
  cols = window_width / WORD_LENGTH
  rows = (files.count.to_f / cols).ceil

  files = files.each_slice(rows).map do |list|
    unless list.count == rows
      (rows - list.count).times do
        list << ''
      end
    end

    list
  end

  files.transpose.each do |file_list|
    puts file_list.map { |file| print file.ljust(WORD_LENGTH) }.join
  end
end
