# frozen_string_literal: true

require 'etc'
require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-a') { |a| option[:a] = a }
opt.on('-r') { |r| option[:r] = r }
opt.on('-l') { |l| option[:l] = l }
opt.parse(ARGV)

def make_cell(rows, cols, files_ordered)
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
    block_num = File.stat(file.to_s).blocks
    block_total += block_num
  end
  puts "total #{block_total}"
end

def make_permission(file_path, permission_num, permission_type)
  permission = file_path.mode.to_s(2)

  if (permission.to_i(2) & 1 << permission_num).zero?
    print '-'
  else
    print permission_type
  end
end

def all_permission(file_path)
  make_permission(file_path, 8, 'r')
  make_permission(file_path, 7, 'w')
  make_permission(file_path, 6, 'x')
  make_permission(file_path, 5, 'r')
  make_permission(file_path, 4, 'w')
  make_permission(file_path, 3, 'x')
  make_permission(file_path, 2, 'r')
  make_permission(file_path, 1, 'w')
  make_permission(file_path, 0, 'x')
end

def other_print(file_path, file)
  link = file_path.nlink
  user = Etc.getpwuid(file_path.uid).name
  group = Etc.getgrgid(file_path.gid).name
  size = file_path.size
  time_stanp = file_path.mtime.to_a
  hour = format('%02d', time_stanp[2])
  minutes = format('%02d', time_stanp[1])

  print link.to_s.rjust(3)
  print user.to_s.rjust(8)
  print group.to_s.rjust(7)
  print size.to_s.rjust(6)
  print time_stanp[4].to_s.rjust(3)
  print time_stanp[3].to_s.rjust(3)
  print "#{hour}:#{minutes} ".rjust(7)
  print file
end

def option_l(files)
  block_sum(files)
  files.each do |file|
    if File.ftype(file.to_s) == 'directory'
      print 'd'
    else
      print '-'
    end

    file_path = File.stat(file.to_s)
    all_permission(file_path)
    other_print(file_path, file)
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
  make_cell(rows, cols, files_ordered)
end
