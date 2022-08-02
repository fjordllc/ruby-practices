require 'optparse'
require 'debug'
require 'date'

def main
  judje_options
end

def judje_options
  options = {}
  OptionParser.new do |opt|
    opt.on('-l', '--long', 'long list'){ |v| options[:l] = v }
    opt.parse!(ARGV)
  end

  if options.has_key?(:l)
    print_option_l
  else
    print_without_option_l
  end
end

def print_option_l
  stat_file = Dir.glob("*").map { |s| File::Stat.new(s) }

  total_blocks = stat_file.map(&:blocks)
  puts "total #{total_blocks.sum}"


  filetype_long = stat_file.map(&:ftype)
  filetype_convert_name = {'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'b', 'file' => '-', 'link' => 'l', 'socket' => 's'}.freeze
  filetype_short = filetype_long.map!{|short| filetype_convert_name[short]  }

  permission_num = stat_file.map(&:mode)
  octal_permission = permission_num.map.each do |num|
    num.to_s(8).to_i % 1000
  end
  octal_permission.map!{|oct| oct.to_s}
  permission = octal_permission.map{ |a| a.gsub(/[0-7]/, '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx') }
  max_permission_width = permission.compact.max_by(&:size).size  + 1
  permission.map! {|space| space.to_s.ljust(max_permission_width)}

  hardlink = stat_file.map(&:nlink)
  hardlink.map! {|space| space.to_s.ljust(3)}

  user_id = stat_file.map(&:uid)
  owner_name = user_id.map{|u|Etc.getpwuid(u).name}
  owner_name.map! {|space| space.to_s.ljust(7)}
  group_id = stat_file.map(&:gid)
  group_name = group_id.map{|u|Etc.getgrgid(u).name}
  group_name.map! {|space| space.to_s.ljust(7)}

  file_byte_size = stat_file.map(&:size)
  file_byte_size.map! {|space| space.to_s.ljust(5)}

  get_time = stat_file.map(&:mtime)
  time_stamp = get_time.map{|time| time.strftime('%_m %_d %_R').to_s.ljust(12)} 
  time_stamp.map! {|space| space.to_s.ljust(10)}

  name = Dir.glob("*")
  max_name_width = name.compact.max_by(&:size).size  + 1
  name.map! {|space| space.to_s.ljust(max_name_width)}

  filetype_short.zip(permission, hardlink, owner_name, group_name, file_byte_size, time_stamp, name) { |ary| puts ary.join }
end

COLUMN_NUMBER = 3
SPACE = 5

def print_without_option_l
  all_files = Dir.glob("*").sort
  display_row_number = (all_files.size.to_f / COLUMN_NUMBER).ceil

  rest_of_row = all_files.size % COLUMN_NUMBER

  max_column_width = all_files.compact.max_by(&:size).size + SPACE
  formatted_content_names = all_files.map {|space| space.to_s.ljust(max_column_width)}
  (display_row_number * COLUMN_NUMBER - all_files.size).times {formatted_content_names.push(nil)} if rest_of_row != 0
  set_of_files_arrays = formatted_content_names.each_slice(display_row_number).to_a

  set_of_files_arrays.transpose.each do |index|
    puts index.join
  end
end

main
