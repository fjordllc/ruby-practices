# frozen_string_literal: true

# !/usr/bin/env ruby

require './file_data'

module Ls
  class Formatter
    def simple(files)
      reformed_files = []
      print_lines = (files.size / 3.to_f).ceil
      files.each_slice(print_lines) do |separated_files|
        separated_files.push(nil) while separated_files.size < print_lines
        reformed_files << separated_files
      end
      reformed_files.transpose.each do |array_files|
        array_files.each do |file|
          print file.to_s.ljust(15)
        end
        print "\n"
      end
    end

    def detail(files)
      puts "total #{total_size(files)}"
      files.each do |file|
        file_data = FileData.new(file)
        print file_data.ftype
        print "#{file_data.permission} "
        print "#{file_data.nlink} ".to_s.rjust(3)
        print "#{file_data.user_name}  "
        print "#{file_data.group_name} "
        print "#{file_data.size.to_s.rjust(5)} "
        print "#{file_data.mtime} "
        puts file_data.name
      end
    end

    private

    def total_size(files)
      files.sum do |n|
        File.stat(n).blocks
      end
    end
  end
end
