# frozen_string_literal: true

MAX_COLUMN_LENGTH = 3

require 'etc'
require 'optparse'

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
  opt.on('-l') { |v| v }
  opt.parse!(ARGV, into: params)

  directory_names = ARGV.empty? ? [Dir.pwd] : ARGV
  directory_names.each do |directory|
    puts directory if directory_names.count > 1
    filesnames = Dir.glob('*', base: directory)
    if params[:l]
      main_option_l(filesnames, directory)
    else
      ls_main(filesnames)
    end
  end
end

def main_option_l(filesnames, directory)
  filesnames.each do |filename|
    user_id    = Process.uid
    user_name  = Etc.getpwuid(user_id).name
    group_id   = Process.gid
    group_name = Etc.getgrgid(group_id).name
    file_path = File.expand_path(filename, directory)
    stat = File::Stat.new(file_path)
    permission_octal = stat.mode.to_s(8)
    permission = conversion_permission(permission_octal)
    puts "#{permission} #{stat.nlink} #{user_name} #{group_name}  #{File.size(file_path)} #{stat.mtime.to_s.slice!(6..15)} #{filename} "
  end
end

def conversion_permission(permission_octal)
  permission_table = { 0 => "---", 1 => "--x", 2 => "-w-", 3 => "-wx", 4 => "r--", 5 => "r-x", 6 => "rw-", 7 => "rwx" }
  overhaul_permission = permission_octal.to_i.digits.reverse
  permission_conversioned = overhaul_permission[-3..-1].map do |n|
    permission_table[n]
  end

  if overhaul_permission[0..1].join == "10"
    permission_conversioned.prepend("--")
  elsif overhaul_permission[0..1].join == "40"
    permission_conversioned.prepend("d-")
  end

  print permission_conversioned.join
end

main
