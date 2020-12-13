##!/bin/sh
exec ruby -x "$0" "$@"
##!ruby

# frozen_string_literal: true

require 'optparse'
require_relative './mystat'
require 'pathname'

opt = OptionParser.new

options = {}

opt.on('-a') { |v| v }
opt.on('-l') { |v| v }
opt.on('-r') { |v| v }

opt.parse!(ARGV, into: options)

file_dir_info = if !ARGV.empty? && !options[:a]
                  args = []
                  ARGV.each do |arg|
                    Pathname.glob(arg) do |pathname|
                      stat = []
                      if pathname.directory?
                        Pathname.glob(pathname.join('*')) do |pathname_|
                          stat << MyStat.new(pathname_)
                        end
                        args << [:other, arg, stat]
                      else
                        stat << MyStat.new(pathname)
                        args << [:first, nil, stat]
                      end
                    end
                  end
                  args
                elsif !ARGV.empty? && options[:a]
                  args = []
                  ARGV.each do |arg|
                    Pathname.glob(arg) do |pathname|
                      stat = []
                      if pathname.directory?
                        arr = []
                        arr << pathname.join('*')
                        arr << pathname.join('.*')
                        Pathname.glob(arr) do |pathname_|
                          stat << MyStat.new(pathname_)
                        end
                        args << [:other, arg, stat]
                      else
                        stat << MyStat.new(pathname)
                        args << [:first, nil, stat]
                      end
                    end
                  end
                  args
                elsif ARGV.empty? && options[:a]
                  args = []
                  stat = []
                  Pathname.glob(['./*', './.*']) do |pathname|
                    stat << MyStat.new(pathname)
                  end
                  args << [:first, nil, stat]
                elsif ARGV.empty? && !options[:a]
                  args = []
                  stat = []

                  Pathname.glob('./*') do |pathname|
                    stat << MyStat.new(pathname)
                  end
                  args << [:first, nil, stat]
                end

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

    display = []
    div = if (fd[2].size % 3).zero?
            fd[2].size / 3
          else
            fd[2].size / 3 + 1
          end

    display_child = []
    i = 0
    fd[2].each do |d|
      display_child << File.basename(d.path)
      if ((i + 1) % div).zero?
        display << display_child
        display_child = []
      end
      i += 1
    end
    display << display_child
    (0...display[0].size).each do |col|
      (0...display.size).each do |row|
        printf('%<display>-30s ', display: display[row][col]) unless display[row][col].nil?
      end
      puts
    end
  end
end
