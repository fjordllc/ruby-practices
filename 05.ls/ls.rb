# frozen_string_literal: true

# !/usr/bin/env ruby

require 'optparse'
require 'etc'

file_and_directory = Dir.glob('*').sort

private

def change_filetype_format(ftype)
  {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's'
  }[ftype]
end

def change_file_mode_format(mode)
  formats = %i[--- --x -w- -wx r-- r-x rw- rwx]
  octal = mode.to_s(8)
  user = octal[-3].to_i
  group = octal[-2].to_i
  others = octal[-1].to_i
  [formats[user], formats[group], formats[others]].join
end

def get_owner_name(uid)
  Etc.getpwuid(uid)
end

def get_group_name(gid)
  Etc.getgrgid(gid)
end

def change_time_format(mtime)
  mtime.strftime('%m %d %H:%M')
end

option_hash = {}
opt = OptionParser.new
opt.on('-a') do
  option_hash[:a] = true
end

opt.on('-l') do
  option_hash[:l] = true
end

opt.on('-r') do
  option_hash[:r] = true
end

opt.parse(ARGV)

file_and_directory = Dir.glob('*', File::FNM_DOTMATCH).sort if option_hash[:a]
file_and_directory = file_and_directory.reverse if option_hash[:r]

if option_hash[:l]
  total = file_and_directory.sum { |a| File.stat(a).blocks }
  puts "total #{total}"
  file_and_directory.each do |file_or_directory|
    stat = File.stat(file_or_directory)
    file_type = change_filetype_format(stat.ftype)
    file_mode = change_file_mode_format(stat.mode)
    owner_name = get_owner_name(stat.uid).name
    group_name = get_group_name(stat.gid).name
    formatted_time = change_time_format(stat.mtime)
    print "#{file_type}#{file_mode} #{stat.nlink} #{owner_name} #{group_name} #{stat.size} #{formatted_time} \
#{file_or_directory}\n"
  end
else
  file_and_directory.each_slice(3) do |file_or_directory|
    puts "#{file_or_directory[0]} #{file_or_directory[1]} #{file_or_directory[2]}"
  end
end
