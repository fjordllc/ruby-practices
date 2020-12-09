# frozen_string_literal: true

# !/usr/bin/env ruby

require 'optparse'
require 'etc'

file_and_directory = Dir.glob('*').sort

private

def ftype_to_one_letter(ftype)
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

def to_rwx_trio(mode)
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
  total = 0
  file_and_directory.each do |c|
    total += File.stat(c).blocks
  end
  puts "total #{total}"
  file_and_directory.each do |f|
    stat = File.stat(f)
    print "#{ftype_to_one_letter(stat.ftype)}#{to_rwx_trio(stat.mode)} #{stat.nlink} #{get_owner_name(stat.uid).name}\
          #{get_group_name(stat.gid).name} #{stat.size} #{change_time_format(stat.mtime)} #{f}\n"
  end
else
  file_and_directory.each_slice(3) do |f|
    puts "#{f[0]} #{f[1]} #{f[2]}"
  end
end
