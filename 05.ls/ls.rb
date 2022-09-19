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

def list_file_type(file_mode)
  file_type = {
    '04' => 'd',
    '10' => '-',
    '12' => 'l'
  }
  type = file_mode[0] + file_mode[1]
  file_type[type]
end

def list_special_perm_suid(file_mode, file_permissions)
  if file_mode[2] == 4 && file_permissions[2] == 'x'
    file_permissions[2] = 'S'
  elsif file_mode[2] == 4
    file_permissions[2] = 's'
  end
end

def list_special_perm_sgid(file_mode, file_permissions)
  if file_mode[2] == 2 && file_permissions[5] == 'x'
    file_permissions[5] = 'S'
  elsif file_mode[2] == 2
    file_permissions[5] = 's'
  end
end

def list_special_perm_sticky(file_mode, file_permissions)
  if file_mode[2] == 1 && file_permissions[8] == 'x'
    file_permissions[8] = 'T'
  elsif file_mode[2] == 1
    file_permissions[8] = 't'
  end
end

def list_file_perm(file_mode)
  file_permissions =
    (3..5).map do |fp|
      fm = file_mode[fp].to_i
      fm_r = fm >= 4 ? 'r' : '-'
      fm -= 4 if fm >= 4
      fm_w = fm >= 2 ? 'w' : '-'
      fm -= 2 if fm >= 2
      fm_x = fm >= 1 ? 'x' : '-'
      [fm_r, fm_w, fm_x]
    end
  list_special_perm_suid(file_mode, file_permissions)
  list_special_perm_sgid(file_mode, file_permissions)
  list_special_perm_sticky(file_mode, file_permissions)
  file_permissions.join
end

def get_files_in_long_format(file_names)
  number_of_files = file_names.size - 1
  (0..number_of_files).map do |nf|
    fs = File::Stat.new(file_names[nf])
    [fs.mode, fs.nlink, fs.uid, fs.gid, fs.size, fs.mtime]
  end
end

def convert_files_in_long_format(files_in_long_format)
  number_of_files = files_in_long_format.size - 1
  (0..number_of_files).map do |nf|
    file_mode_octal = files_in_long_format[nf][0].to_s(8).split(//)
    file_mode_octal.unshift('0') if file_mode_octal.size == 5
    type_and_permissions = [list_file_type(file_mode_octal), list_file_perm(file_mode_octal)].join
    number_of_hard_links = files_in_long_format[nf][1]
    user_name = Etc.getpwuid(files_in_long_format[nf][2]).name
    group_name = Etc.getgrgid(files_in_long_format[nf][3]).name
    file_size = files_in_long_format[nf][4]
    time_stamp = files_in_long_format[nf][5].to_a
    date = Date.new(time_stamp[5], time_stamp[4], time_stamp[3])
    month = date.strftime('%b')
    day = time_stamp[3]
    time = [time_stamp[2], time_stamp[1]].join(':')
    [type_and_permissions, number_of_hard_links, user_name, group_name, file_size, month, day, time]
  end
end

def list_files_in_long_format(file_names)
  print 'total '
  puts count_blocks(file_names)
  file_before_conversion = get_files_in_long_format(file_names)
  file_after_conversion = convert_files_in_long_format(file_before_conversion)
  number_of_files = file_names.size - 1
  (0..number_of_files).each do |nf|
    (0..7).each do |n|
      print "#{file_after_conversion[nf][n]} "
    end
    puts file_names[nf]
  end
end

if options['l']
  list_files_in_long_format(Dir.glob('*'))
else
  list_files(Dir.glob('*'))
end
