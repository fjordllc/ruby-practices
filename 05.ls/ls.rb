#!/usr/bin/env ruby

require 'optparse'
require 'date'

opt = OptionParser.new

params = {}

opt.on('-r') {|v| params[:r] = v }
opt.on('-l') {|v| params[:l] = v }
opt.on('-a') {|v| params[:a] = v }

opt.parse!(ARGV)

if ARGV.count == 0
end

WORD_LENGTH= 24

files = Dir.glob('*')

window_width = %x{ tput cols }.chomp.to_i

cols =  window_width / WORD_LENGTH

rows = (files.count.to_f / cols.to_f).ceil

files = files.sort.each_slice(rows).map do |list|
  if list.count != rows
    (rows - list.count).times do
      list << ''
    end
  end

  list
end

files.transpose.each do |files|
  puts files.map { |file| print file.ljust(WORD_LENGTH) }.join
end
