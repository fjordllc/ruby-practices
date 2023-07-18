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

def make_permission(file_path, file, y, b)
  permission = file_path.mode.to_s(2)

  if (permission.to_i(2) & 1 << y) == 0
    print "-"
  else
    print b
  end
end

def option_l(files)
  block_sum(files)
  files.each do |file|
    if File.ftype("#{file}") == "directory"
      print "d"
    else
      print "-"
    end
    
    file_path = File.stat("#{file}")
    permission = file_path.mode.to_s(2)
    make_permission(file_path, file, 8, "r")
    make_permission(file_path, file, 7, "w")
    make_permission(file_path, file, 6, "x")
    make_permission(file_path, file, 5, "r")
    make_permission(file_path, file, 4, "w")
    make_permission(file_path, file, 3, "x")
    make_permission(file_path, file, 2, "r")
    make_permission(file_path, file, 1, "w")
    make_permission(file_path, file, 0, "x")
    
    link = file_path.nlink
    user = Etc.getpwuid(file_path.uid).name
    group = Etc.getgrgid(file_path.gid).name
    size = file_path.size
    time_stanp = file_path.mtime.to_a
    hour = sprintf("%02d", time_stanp[2])
    minutes = sprintf("%02d", time_stanp[1])

    print "#{link}".rjust(3)
    print "#{user}".rjust(8)
    print "#{group}".rjust(7)
    print "#{size}".rjust(6)
    print "#{time_stanp[4]}".rjust(3)
    print "#{time_stanp[3]}".rjust(3)
    print "#{hour}:#{minutes}".rjust(6)
    print " #{file}"
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
  option_l(files)
else
  make_cell(rows, cols, files_ordered, option)
end
