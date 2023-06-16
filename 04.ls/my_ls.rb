#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
COLUMN_NUMBER = 3

def line_up_files
  files = files_with_space
  files_number = files.count
  rows = (files_number / COLUMN_NUMBER.to_f).ceil
  (COLUMN_NUMBER - files_number % COLUMN_NUMBER).times { files << '' } if files_number % COLUMN_NUMBER != 0
  output(files, rows)
end

def files_with_space
  has_options = options
  files = (has_options[:a] ? Dir.entries('.').sort : Dir.glob('*'))
  files.reverse! if has_options[:r]
  filename_max_length = files.map(&:size).max + 7
  files.map { |file| file.ljust(filename_max_length) }
end

def options
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:a] = v }
  opt.on('-r') { |v| params[:r] = v }
  opt.parse!
  params
end

def output(files, rows)
  output_files = []
  files.each_slice(rows) do |file|
    output_files << file
  end

  output_files.transpose.each do |file|
    file.each { |filename| print filename }
    puts "\n"
  end
end

line_up_files
