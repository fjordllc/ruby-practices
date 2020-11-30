# frozen_string_literal: true

# !/usr/bin/env ruby

require 'etc'
require './file_data'

module Ls
  class Format
    def horizontal_row(files)
      files.each do |file|
        print "#{file}  "
      end
    end

    def title_size(files)
      total = []
      files.each do |n|
        total.push(File.stat(n).blocks)
      end
      total.sum.to_s
    end

    def print_permission(index)
      oct_to_rwx = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }
      permission = ''
      File::Stat.new(index).mode.to_s(8)[-3..].chars.each do |per|
        oct_to_rwx.each do |kye, val|
          permission = val if kye == per
        end
        print permission
      end
    end

    def horizontal_rows(files)
      puts "total #{title_size(files)}"
      files.each do |index|
        print 'd' if File::Stat.new(index).ftype == 'directory'
        print 'l' if File::Stat.new(index).ftype == 'link'
        print '-' if File::Stat.new(index).ftype == 'file'
        print_permission(index)
        print ' '
        print "#{File::Stat.new(index).nlink}  "
        print "#{Etc.getpwuid(File::Stat.new(index).uid).name}  "
        print "#{Etc.getgrgid(File::Stat.new(index).gid).name}  "
        print "#{File::Stat.new(index).size}  "
        print "#{File::Stat.new(index).mtime.strftime('%m %-d %H:%M')} "
        puts index.to_s
      end
    end
  end
end
