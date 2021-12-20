# frozen_string_literal: true

require 'optparse'

MAX_COLUMN_LENGTH = 3

def ls_main(filesnames)
  fulfilled_filesnames = complete_filesnames(filesnames)
  grouped_filesnames = fulfilled_filesnames.each_slice(get_max_line_length(filesnames)).to_a
  transposed_filesnames = grouped_filesnames.transpose
  output(transposed_filesnames)
end

def complete_filesnames(filesnames)
  count_files_mod_by_three = filesnames.count % MAX_COLUMN_LENGTH
  where_add_nil = locate_nil(filesnames)
  add_nil(where_add_nil, filesnames, count_files_mod_by_three)
end

def locate_nil(filesnames)
  max_line_length = get_max_line_length(filesnames)
  { the_end_of_second_column_index: (max_line_length * 2).pred,
    the_end_of_third_column_index: (max_line_length * 3).pred }
end

def get_max_line_length(filesnames)
  count_files = filesnames.count
  count_files_mod_by_three = filesnames.count % MAX_COLUMN_LENGTH
  if count_files_mod_by_three.zero?
    count_files / MAX_COLUMN_LENGTH
  else
    (count_files / MAX_COLUMN_LENGTH).next
  end
end

def add_nil(where_add_nil, filesnames, count_files_mod_by_three)
  case count_files_mod_by_three
  when 1
    filesnames.insert(where_add_nil[:the_end_of_second_column_index], nil)
    filesnames.insert(where_add_nil[:the_end_of_third_column_index], nil)
  when 2
    filesnames.insert(where_add_nil[:the_end_of_third_column_index], nil)
  else
    filesnames
  end
  filesnames
end

def output(transposed_filesnames)
  transposed_filesnames.each do |file_line|
    puts file_line.compact.join('  ')
  end
end

def main
  params = {}
  opt = OptionParser.new
  opt.on('-r') { |v| v }
  opt.parse!(ARGV, into: params)

  directory_names = ARGV.empty? ? [Dir.pwd] : ARGV
  directory_names.each do |directory|
    puts directory if directory_names.count > 1
    base_filesnames = Dir.glob('*', base: directory)
		filesnames = base_filesnames.tap{|b| break b.reverse if params[:r]}
    ls_main(filesnames)
  end
end

main
