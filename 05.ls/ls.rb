# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'

options = ARGV.getopts('l',
                       'long format(-l)  use a long listing format.')

# columns to display on the screen
COLUMN_MAX = 3

def count_group_size(file_names)
  file_names.size / COLUMN_MAX + 1
end

def divide_into_groups(file_names)
  file_names
    .map { |fname| fname.ljust(file_names.map(&:size).max) }
    .each_slice(count_group_size(file_names))
    .to_a
end

def list_files(file_names)
  file_names_in_groups = divide_into_groups(file_names)
  column = file_names_in_groups.size - 1
  row = count_group_size(file_names)
  (0..row).each do |r|
    (0..column).each do |c|
      print "#{file_names_in_groups[c][r]} "
    end
    puts '' unless r == row
  end
end

def count_blocks(file_names)
  number_of_files = file_names.size - 1
  (0..number_of_files).map do |nf|
    fs = File::Stat.new(file_names[nf])
    fs.blocks / 2
  end.sum
end

#def file_type
#  case file_mode_8[0] + file_mode_8[1]
#  when 04
#    d
#  when 10
#    -
#  when 12
#    l
#  else
#    " "
#  end 
#end
#def file_permissions
#  case file_mode_8[3..5]
#  when 4
#   r
#  when 2
#    w
#  when 1
#    x
# else
#    -
#  end
#end
def list_file_permissions(file_mode)
  file_permissions = Array.new
  file_mode_r = file_mode
  (3..5).map do |fp|
    if file_mode_r[fp].to_i >= 4
      file_mode_w = file_mode_r[fp].to_i - 4
      file_permissions.push('r')
    else
      file_mode_w = file_mode_r[fp].to_i
      file_permissions.push('-')
    end
    if file_mode_w >= 2
      file_mode_x = file_mode_w - 2
      file_permissions.push('w')
    else
      file_mode_x = file_mode_w
      file_permissions.push('-')
    end
    if file_mode_x >= 1
      file_permissions.push('x')
    else
      file_permissions.push('-')
    end
  end
  p file_permissions.join
end

#def special_permissions
#  case file_mode_8[2]
#  when 1
#    file_mode_8[5] = --t
#  when 2
#    file_mode_8[4] = --s
#  when 4
#    file_mode_8[3] = --s
#  else
#    ""
#  end
#end

def list_files_in_long_format(file_names)
  number_of_files = file_names.size - 1
  print 'total '
  puts count_blocks(file_names)
  (0..number_of_files).each do |nf|
    fs = File::Stat.new(file_names[nf])
    file_mode_8 = fs.mode.to_s(8).split(//)
    file_mode_8.unshift("0") if file_mode_8.size == 5
    list_file_permissions(file_mode_8)
    number_of_hard_links = fs.nlink
    user_name = Etc.getpwuid(fs.uid).name
    group_name = Etc.getgrgid(fs.gid).name
    file_size = fs.size
    time_stamp = fs.mtime.to_a
    date = Date.new(time_stamp[5], time_stamp[4], time_stamp[3])
    month = date.strftime('%b')
    day = time_stamp[3]
    hour = time_stamp[2]
    minutes = time_stamp[1]
    puts "#{file_mode_8} #{number_of_hard_links} #{user_name} #{group_name} #{file_size} #{month} #{day} #{hour}:#{minutes} #{file_names[nf]}"
  end
end

if options['l']
  list_files_in_long_format(Dir.glob('*'))
else
  list_files(Dir.glob('*'))
end
