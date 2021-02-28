#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative './mystat'
require 'pathname'

def dir_stat(pathname, opt)
  stat = []
  arr = []
  arr << pathname.join('*')
  arr << pathname.join('.*') if opt
  pathname.glob(arr) do |pathname_|
    stat << MyStat.new(pathname_)
  end
  stat
end

def file_dir(input, opt)
  args = []
  if input == false
    ARGV.each do |arg|
      Pathname.glob(arg) do |pathname|
        stat = []
        if pathname.directory?
          stat = dir_stat(pathname, opt)
          args << [:other, arg, stat]
        else
          stat << MyStat.new(pathname)
          args << [:first, nil, stat]
        end
      end
    end
  else
    stat = dir_stat(Pathname('./'), opt)
    args << [:first, nil, stat]
  end
  args
end

option = OptionParser.new

options = {}

option.on('-a') { |v| v }
option.on('-l') { |v| v }
option.on('-r') { |v| v }

option.parse!(ARGV, into: options)

file_dir_info = file_dir(ARGV.empty?, options[:a])

file_dir_info.sort! do |a, b|
  (a[0] <=> b[0]).nonzero? || (a[1] <=> b[1])
end

file_dir_info.each do |x|
  x[2].sort! do |a, b|
    File.basename(a.path) <=> File.basename(b.path)
  end
end

if options[:r]
  file_dir_info.sort! do |a, b|
    (a[0] <=> b[0]).nonzero? || (b[1] <=> a[1])
  end

  file_dir_info.each do |x|
    x[2].sort! do |a, b|
      File.basename(b.path) <=> File.basename(a.path)
    end
  end
end

if options[:l]
  file_dir_info.each do |fd|
    puts "#{fd[1]} :" unless fd[0] == :first
    fd[2].each(&:my_print)
  end
else
  file_dir_info.each do |fd|
    puts "#{fd[1]} :" unless fd[0] == :first

    datas = []
    div = if (fd[2].size % 3).zero?
            fd[2].size / 3
          else
            fd[2].size / 3 + 1
          end

    data_child = []

    fd[2].each.with_index do |d, i|
      data_child << File.basename(d.path)
      if ((i + 1) % div).zero?
        datas << data_child
        data_child = []
      end
    end
    datas << data_child
    datas.each do |dataset|
      dataset.each do |item|
        printf('%<display>-30s ', display: item) unless item.nil?
      end
      puts
    end
  end
end
