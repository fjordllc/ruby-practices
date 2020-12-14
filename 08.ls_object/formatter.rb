# frozen_string_literal: true

# !/usr/bin/env ruby

require 'etc'
require './file_data'

module Ls
  class Formatter
    def simple(files)
      reform_files = []
      i = if (files.size % 3).zero?
            files.size.div(3)
          else
            files.size.div(3) + 1
          end
      files.each_slice(i) do |separated_files|
        separated_files.push(nil) while separated_files.size < i
        reform_files << separated_files
      end
      reform_files.transpose.each do |array_files|
        array_files.each do |file|
          print file.to_s.ljust(15)
        end
        print "\n"
      end
    end

    def detail(files)
      puts "total #{total_size(files)}"
      files.each do |file|
        stat = File::Stat.new(file)
        print ftype(stat)
        print_permission(file)
        print ' '
        print "#{stat.nlink} ".to_s.rjust(3)
        print "#{Etc.getpwuid(stat.uid).name}  "
        print "#{Etc.getgrgid(stat.gid).name} "
        print "#{stat.size.to_s.rjust(5)} "
        print "#{stat.mtime.strftime('%m %e %H:%M')} "
        puts file
      end
    end

    private

    def total_size(files)
      files.sum do |n|
        File.stat(n).blocks
      end
    end

    def ftype(stat)
      case stat.ftype
      when 'directory'
        print 'd'
      when 'link'
        print 'l'
      when 'file'
        print '-'
      end
    end

    OCT_TO_RWX = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }.freeze

    def print_permission(file)
      permission = File::Stat.new(file).mode.to_s(8)[-3..]
      permission.each_char do |digit|
        print OCT_TO_RWX[digit]
      end
    end
  end
end
