#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

class Files
  attr_accessor :type, :permission, :owner, :group, :name, :time, :symbolic_link, :hard_link, :size

  def initialize(type, permission, owner, group, time)
    @type = type
    @permission = permission
    @owner = owner
    @group = group
    @time = time
  end
end

def main(files)
  files.reverse! if ARGV.join.include?('r')
  if ARGV.join.include?('l')
    long(files)
  else
    display(files)
  end
end

def display(files)
  name_size = files.map { |file| file.name.size }
  width = name_size.max + 6
  file_names = files.map { |file| file.name.ljust(width) }
  rows = file_names.size.divmod(3)
  (2 / rows[1]).times { file_names.push(nil) } unless (rows[1]).zero?
  file_names.each_slice(file_names.size / 3).to_a.transpose.each do |row|
    row.each { |file| print file }
    puts "\n"
  end
end

def long(files)
  total = files.map.sum { |f| (f.size / 4906.0).round * 8 }
  puts "total #{total}"
  hard_link_size = files.map { |file| file.hard_link.to_s.size }
  size_size = files.map { |file| file.size.to_s.size }
  files.each do |f|
    a = <<~TEXT
      #{f.type}#{f.permission} #{f.hard_link.to_s.rjust(hard_link_size.max + 1)} #{f.owner}  \
      #{f.group}  #{f.size.to_s.rjust(size_size.max)} #{f.time} #{f.name} #{f.symbolic_link}
    TEXT
    print a
  end
end

def mode_to_char(mode)
  ary = mode.to_s(8)[-3..].chars
  mode_char = []
  ary.map do |a|
    mode_char <<
      case a
      when '0' then '---'
      when '1' then '--x'
      when '2' then '-w-'
      when '3' then '-wx'
      when '4' then 'r--'
      when '5' then 'r-x'
      when '6' then 'rw-'
      else
        'rwx'
      end
  end
  mode_char
end

file_names = Dir.foreach('.').to_a
file_names.sort!
file_status = file_names.map { |f| File.stat(f) }

files = file_status.map { |f| Files.new(f.ftype[0], f.mode, f.uid, f.gid, f.ctime) }

files.each_with_index do |file, n|
  file.hard_link = file_status[n].nlink
  file.size = file_status[n].size
end

files.each do |file|
  file.permission = mode_to_char(file.permission).join
  file.owner = Etc.getpwuid(file.owner).name
  file.group = Etc.getgrgid(file.group).name
  file.type = '-' if file.type == 'f'
  file.time = file.time.strftime('%b %e %R')
end

file_names.each_with_index do |name, n|
  files[n].name = name
  if File.ftype(file_names[n]) == 'link'
    files[n].symbolic_link = "-> #{File.readlink(name)}"
    files[n].type = 'l'
  end
end

hidden_files = files.slice!(0..file_names.rindex { |f| f.match(/^\./) })

opt = OptionParser.new
opt.on('-a', 'display all') do
  hidden_files.reverse_each { |f| files.unshift f }
end
opt.on('-r', 'display reverse')
opt.on('-l', 'display long')
opt.parse(ARGV)

main(files)
