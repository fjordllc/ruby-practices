# frozen_string_literal: true

# !/usr/bin/env ruby

require 'optparse'
require 'etc'

current_directory = Dir.glob('*').sort

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
  u = octal[-3].to_i
  g = octal[-2].to_i
  o = octal[-1].to_i
  [formats[u], formats[g], formats[o]].join
end

def get_owner_name(uid)
  Etc.getpwuid(uid)
end

def get_group_name(gid)
  Etc.getgrgid(gid)
end

def to_ls_time_format(mtime)
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

current_directory = Dir.glob('*', File::FNM_DOTMATCH).sort if option_hash[:a]
current_directory = current_directory.reverse if option_hash[:r]

if option_hash[:l]
  total = 0
  current_directory.each do |c|
    stat = File.stat(c)
    total += stat.blocks
  end
  puts "total #{total}"
  current_directory.each do |f|
    stat = File.stat(f)
    print "#{ftype_to_one_letter(stat.ftype)}#{to_rwx_trio(stat.mode)} #{stat.nlink} #{get_owner_name(stat.uid).name}\
 #{get_group_name(stat.gid).name} #{stat.size} #{to_ls_time_format(stat.mtime)} #{f}\n"
 #    puts ''
  end
else
  current_directory.each.with_index(0) do |f, i|
    print f.ljust(16)
    i += 1
    puts '' if (i % 3).zero?
  end
end
