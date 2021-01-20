#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

module List
end

class List::File
  attr_reader :hard_link, :size
  attr_accessor :type, :permission, :owner, :group, :name, :time, :symbolic_link

  def initialize(type, permission, hard_link, owner, group, size, time)
    @type = type
    @permission = permission
    @hard_link = hard_link
    @owner = owner
    @group = group
    @size = size
    @time = time
  end

  def self.mode_to_abc(mode)
    ary = mode.to_s(8)[-3..].chars
    mode_abc = []
    ary.map do |a|
      mode_abc <<
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
    mode_abc
  end

  file_names =
    Dir.foreach('.').map { |f| f }
  file_names.sort!

  file_status =
    file_names.map { |f| File.stat(f) }

  FILES =
    file_status.map do |f|
      List::File.new(f.ftype[0], f.mode, f.nlink, f.uid, f.gid, f.size, f.ctime)
    end

  FILES.each do |file|
    file.permission = List::File.mode_to_abc(file.permission).join
    file.owner = Etc.getpwuid(file.owner).name
    file.group = Etc.getgrgid(file.group).name
    file.type = '-' if file.type == 'f'
    file.time = file.time.strftime('%b %e %R')
  end

  file_names.each_with_index do |name, n|
    FILES[n].name = name
    if File.ftype(file_names[n]) == 'link'
      FILES[n].symbolic_link = "-> #{File.readlink(name)}"
      FILES[n].type = 'l'
    end
  end

  HIDDEN_FILES =
    FILES.slice!(0..file_names.rindex { |f| f.match(/^\./) })

  HARD_LINK_SIZE = FILES.map { |file| file.hard_link.to_s.size }
  SIZE_SIZE = FILES.map { |file| file.size.to_s.size }
  NAME_SIZE = FILES.map { |file| file.name.size }
end

class Exec < List::File
  opt = OptionParser.new
  opt.on('-a', 'display all') do
    HIDDEN_FILES.reverse_each { |f| FILES.unshift f }
  end
  opt.on('-r', 'display reverse')
  opt.on('-l', 'display long')
  opt.parse(ARGV)

  def self.display(files)
    files.each_with_index do |file, n|
      width = NAME_SIZE.max + 6
      if NAME_SIZE.max > 20 || files.size > 6
        rows = files.size / 3
        if (files.size % 3).zero?
          puts "#{file.name.ljust(width)} #{(files[n + rows]).name.ljust(width)} #{(files[n + rows * 2]).name}" if n <= rows - 1
        elsif files.size % 3 == 1
          puts "#{file.name.ljust(width)} #{(files[n + rows + 1]).name.ljust(width)} #{(files[n + rows * 2 + 1]).name}" if n <= rows - 1
          puts files[rows].name if n == rows
        else
          puts "#{file.name.ljust(width)} #{(files[n + rows + 1]).name.ljust(width)} #{(files[n + rows * 2 + 2]).name}" if n <= rows - 1
          puts "#{files[rows].name.ljust(width)} #{(files[rows * 2 + 1]).name}" if n == rows
        end
      else
        print file.name.ljust(width) if n <= files.size
        puts "\n" if n == files.size - 1
      end
    end
  end

  def self.long(files)
    total =
      files.map.sum { |f| (f.size / 4906.0).round * 8 }
    puts "total #{total}"
    files.each do |f|
      puts "#{f.type}#{f.permission} #{f.hard_link.to_s.rjust(HARD_LINK_SIZE.max + 1)} #{f.owner}  \
#{f.group} #{f.size.to_s.rjust(SIZE_SIZE.max)} #{f.time} #{f.name} #{f.symbolic_link}"
    end
  end
end

if ARGV.join.include?('r')
  List::File::FILES.reverse!
  if ARGV.join.include?('l')
    Exec.long(List::File::FILES)
  else
    Exec.display(List::File::FILES)
  end
elsif ARGV.join.include?('l')
  Exec.long(List::File::FILES)
else
  Exec.display(List::File::FILES)
end
