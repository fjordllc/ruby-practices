# !/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'

def file_names
  Dir.glob('*').sort
end

def file_mode_permission(file)
  eight_ary = File::Stat.new(file).mode.to_s(8)
  alignment = format('%06d', eight_ary)
end

def file_type(file)
  details_filename = File::Stat.new(file)
  if details_filename.ftype == 'directory'
    'd'
  elsif details_filename.ftype == 'file'
    '-'
  else
    details_filename.ftype == 'link'
    'l'
  end
end

def file_eachpermission_index_three(file)
  file_eachpermission_number = file_mode_permission(file)[3]
  case file_mode_permission(file)[3]
  when '0' then '---'
  when '1' then '--x'
  when '3' then '-wx'
  when '4' then 'r--'
  when '5' then 'r-x'
  when '6' then 'rw-'
  when '7' then 'rwx'
  end
end

def file_eachpermission_index_four(file)
  file_eachpermission_number = file_mode_permission(file)[4]
  case file_mode_permission(file)[4]
  when '0' then '---'
  when '1' then '--x'
  when '3' then '-wx'
  when '4' then 'r--'
  when '5' then 'r-x'
  when '6' then 'rw-'
  when '7' then 'rwx'
  end
end

def file_eachpermission_index_five(file)
  file_eachpermission_number = file_mode_permission(file)[5]
  case file_mode_permission(file)[5]
  when '0' then '---'
  when '1' then '--x'
  when '3' then '-wx'
  when '4' then 'r--'
  when '5' then 'r-x'
  when '6' then 'rw-'
  when '7' then 'rwx'
  end
end

def file_eachpermission(file)
  modestring = [file_type(file)] + [file_eachpermission_index_three(file)] + [file_eachpermission_index_four(file)] + [file_eachpermission_index_five(file)]
  modestring.join
end

total_blocks = File::Stat.new($0).blocks
total = ['total'] + [' '] + [total_blocks]
puts total.join

file_names.each do |f|
  details_filename = File::Stat.new(f) # 常に最大桁数(最大の桁を撮ってくる(今回の場合は4桁))に合わせて表示する
  details = [file_eachpermission(f)] + [details_filename.nlink] + [Etc.getpwuid(details_filename.uid).name] + [Etc.getgrgid(details_filename.gid).name] + [details_filename.size] + [details_filename.mtime.strftime('%m %e %H:%M')] + [f]
  puts details.join('    ')
end

# TAB_WIDTH = 8
# COLUMN_COUNT = 3

# file_names = Dir.glob("*").sort
# file_names = Dir.glob("*").sort.reverse #-r
# file_names = Dir.glob("*", File::FNM_DOTMATCH).sort #-a
# file_names = Dir.glob("*", File::FNM_DOTMATCH).sort.reverse #-ar

# longest_file_name = file_names.max_by(&:size).size
# width = TAB_WIDTH * (longest_file_name / TAB_WIDTH.to_f).ceil

# formatted_file_names = file_names.map {|file_name| file_name.ljust(width)}

# row_count = (file_names.size.to_f / COLUMN_COUNT).ceil
# nested_file_names = formatted_file_names.each_slice(row_count).to_a

# nested_file_names = nested_file_names.map {|inner_file_names| inner_file_names.values_at(0...row_count)}
# nested_file_names.transpose.each do |file|
#   puts file.join(' ')
# end
