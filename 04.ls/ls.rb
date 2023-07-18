# frozen_string_literal: true
 require 'debug'
require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-a') { |a| option[:a] = a }
opt.on('-r') { |r| option[:r] = r }
opt.on('-l') { |l| option[:l] = l }
opt.parse(ARGV)

def make_cell(rows, cols, files_ordered, option)
  rows.each do |row|
    cols.each do |col|
      break if files_ordered[row + col * rows.size].nil?
    
      print files_ordered[row + col * rows.size].ljust(26)
    end

    puts
  end
end

def block_sum(files)
  block_total = 0
  files.each do |file|
    block_num = File.stat("#{file}").blocks
    block_total += block_num
  end
  puts "total #{block_total}"
end

def option_l(files)
  block_sum(files)
  files.each do |file|
    if File.ftype("#{file}") == "directory"
      print "d"
    else
      print "-"
    end
    
    print File.stat("#{file}").mode.to_s(2)
    print file
    puts
  end
end

flags = option[:a] ? File::FNM_DOTMATCH : 0
files = Dir.glob('*', flags)

files_ordered = option[:r] ? files.reverse : files.sort

COL_NUM = 3
row_num = (files.size / COL_NUM.to_f).ceil

cols = (0..COL_NUM - 1)
rows = (0..row_num - 1)

if option[:l]
  # debugger
  option_l(files)
else
  make_cell(rows, cols, files_ordered, option)
end
