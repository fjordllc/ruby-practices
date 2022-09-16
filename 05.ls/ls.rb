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

def list_files_in_long_format(file_names)
  number_of_files = file_names.size - 1
  print 'total '
  puts count_blocks(file_names)
  (0..number_of_files).each do |nf|
    fs = File::Stat.new(file_names[nf])
    file_mode_8 = fs.mode.to_s(8).split(//)
    file_mode_8.unshift("0") if file_mode_8.size == 5
    def file_type
      case file_mode_8[0] + file_mode_8[1]
      when 04
        d
      when 10
        -
      when 12
        l
      else
        " "
      end 
    end
    def file_permissions
      case file_mode_8[3..5]
      when 4
        r
      when 2
        w
      when 1
        x
      else
        -
      end
    end
    def special_permissions
    case file_mode_8[2]
    when 1
      file_mode_8[5] = --t
    when 2
      file_mode_8[4] = --s
    when 4
      file_mode_8[3] = --s
    else
      ""
    end
    print file_mode_8
    print " "
    print fs.nlink
    print " "
    print Etc.getpwuid(fs.uid).name
    print " "
    print Etc.getgrgid(fs.gid).name
    print " "
    print fs.size
    print " "
    print Date.new(fs.mtime.to_a[5], fs.mtime.to_a[4], fs.mtime.to_a[3]).strftime('%b')
    print " "
    print fs.mtime.to_a[3]
    print " "
    print fs.mtime.to_a[2]
    print ":"
    print fs.mtime.to_a[1]
    print " "
    puts file_names[nf]
  end
end

if options['l']
  list_files_in_long_format(Dir.glob('*'))
else
  list_files(Dir.glob('*'))
end
