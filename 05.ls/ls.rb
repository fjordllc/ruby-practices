#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

MAX_COLUMN = 3

def print_file_list
  file_list = fetch_file_list

  max_word_count = file_list.max_by(&:length).length
  max_row = file_list.size / MAX_COLUMN + 1

  separated_list = file_list.each_slice(max_row).to_a

  formatted_list = separated_list.map do |file_names|
    file_names.values_at(0..max_row - 1).map do |file_name|
      file_name.to_s.ljust(5 + max_word_count)
    end
  end

  puts formatted_list.transpose.map(&:join)
end

def fetch_file_list
  options = ARGV.getopts('l')
  ls_dir = ARGV[0] || '.'

  file_list = Dir.foreach(ls_dir).to_a.reject { |file_name| file_name.start_with?('.') }
  file_list.each do |file|
    file_state = File.stat(file)
    file_state_array = file_state.mode.to_s(8).rjust(6, '0').split('')
    
    file_type = if file_state_array[0] + file_state_array[1] == '10'
                  '-'
                elsif file_state_array[0] + file_state_array[1] == '04'
                  'd'
                else
                  'l'
                end
                  
                
        
    correspondence_table = {'0'=> '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx'}

    number_of_hard_link = file_state.nlink
    user_name = Etc.getpwuid(file_state.uid).name
    group_name = Etc.getgrgid(file_state.gid).name
    file_size = file_state.size
    timestamp = file_state.mtime.strftime('%b %d %R')

    puts(file_type + correspondence_table[file_state_array[3]] + correspondence_table[file_state_array[4]]+ correspondence_table[file_state_array[5]] + '  ' + number_of_hard_link.to_s + ' ' + user_name + '  ' + group_name + '  ' + file_size.to_s + ' ' + timestamp.to_s + ' ' +file)


  end

  if options['r']
    file_list.sort do |a,b|
      
    end.reverse
  else
    file_list.sort
  end
end

print_file_list
