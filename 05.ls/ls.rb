#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require 'date'
require 'etc'

WORD_LENGTH = 16

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
  format = time.year == Time.now.year ? '%_m %_d %H:%M' : '%_m %_d  %Y'
  time.strftime(format)
end

def directory_or_file(name)
  if Dir.exist?(name)
    if name.end_with?('/')
      name
    else
      "#{name}/"
    end
  elsif name.end_with?('/')
    puts "ls: #{name}: Not a directory"
    nil
  elsif File.exist?(name)
    name
  else
    puts "ls: #{name}: No such file or directory"
    nil
  end
end

def puts_long_option(value, padding_hash)
  value.each do |hash|
    fs = File.stat(hash[:file])

    result = "#{ftype_and_permission(fs.mode.to_s(8))}  " # ファイルタイプ アクセス権
    result += "#{fs.nlink.to_s.rjust(padding_hash[:nlink])} " # ハードリンク数
    result += "#{user_name(fs.uid).rjust(padding_hash[:user])}  " # 所有者名
    result += "#{group_name(fs.gid).rjust(padding_hash[:group])}  " # グループ名
    result += "#{fs.size.to_s.rjust(padding_hash[:size])} " # バイト数
    result += "#{time(fs.mtime)} #{hash[:basename]}" # 更新日時（または更新年月日） ファイル名

    puts result
  end
end

def long_option(value)
  padding_hash = {
    nlink: 0,
    user: 0,
    group: 0,
    size: 0
  }

  total_block_count = 0

  value.each do |hash|
    fs = File.stat(hash[:file])

    # Set padding count
    padding_hash[:nlink] = fs.nlink.to_s.length if fs.nlink.to_s.length > padding_hash[:nlink]
    padding_hash[:user] = user_name(fs.uid).length if user_name(fs.uid).length > padding_hash[:user]
    padding_hash[:group] = group_name(fs.gid).length if group_name(fs.gid).length > padding_hash[:group]
    padding_hash[:size] = fs.size.to_s.length if fs.size.to_s.length > padding_hash[:size]

    # Reduce total blocks
    total_block_count += fs.blocks
  end

  puts "total #{total_block_count}"
  puts_long_option(value, padding_hash)
end

# Implements

opt = OptionParser.new

params = {}

opt.on('-r') { |v| params[:r] = v }
opt.on('-l') { |v| params[:l] = v }
opt.on('-a') { |v| params[:a] = v }

opt.parse!(ARGV)

pattern = if ARGV.empty?
            '*'
          else
            ARGV
              .map { |arg| directory_or_file(arg) }
              .compact
              .map { |file| "#{file}*" }
          end

flags = params[:a] ? File::FNM_DOTMATCH : 0

files = Dir.glob(pattern, flags).sort
files = files.reverse if params[:r]

file_hash = {}

files.each do |file|
  dirname = File.dirname(file)
  basename = File.basename(file)

  if file_hash.key?(dirname)
    file_hash[dirname] << {
      basename: basename,
      file: file
    }
  else
    file_hash[dirname] = [{
      basename: basename,
      file: file
    }]
  end
end

file_hash = if params[:r]
              file_hash.sort.reverse
            else
              file_hash.sort
            end

file_hash.each_with_index do |(key, value), idx|
  if file_hash.count > 1
    puts if idx != 0
    puts "#{key}:"
  end

  if params[:l]
    long_option(value)
  else
    window_width = `tput cols`.chomp.to_i
    cols = window_width / WORD_LENGTH
    rows = (value.count.to_f / cols).ceil

    files = value.map { |h| h[:basename] }.each_slice(rows).map do |list|
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
end
