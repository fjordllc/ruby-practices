# frozen_string_literal: true

require 'optparse'
require 'etc'

DISPLAY_DETAILS_COUNT = 7

FILE_TYPE_HASH = {
  '01' => 'p',
  '02' => 'c',
  '04' => 'd',
  '06' => 'b',
  '10' => '-',
  '12' => 'l',
  '14' => 's'
}.freeze

FILE_ACCESS_RIGHTS_HASH = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def target_directory_files(options)
  target_files = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
  options['r'] ? target_files.reverse : target_files
end

def translate_mode(mode)
  file_type = FILE_TYPE_HASH[mode.slice(0, 2)]
  file_access_right_user = FILE_ACCESS_RIGHTS_HASH[mode.slice(3)]
  file_access_right_group = FILE_ACCESS_RIGHTS_HASH[mode.slice(4)]
  file_access_right_other = FILE_ACCESS_RIGHTS_HASH[mode.slice(5)]
  "#{file_type}#{file_access_right_user}#{file_access_right_group}#{file_access_right_other}"
end

def translate_uid(uid)
  Etc.getpwuid(uid).name
end

def translate_gid(gid)
  Etc.getgrgid(gid).name
end

def translate_date(date)
  if date.year == Time.now.year
    "#{date.day} #{date.month} #{date.hour.to_s.rjust(2, '0')}:#{date.min.to_s.rjust(2, '0')}"
  else
    "#{date.day} #{date.month} #{date.year}"
  end
end

def parse_input(command_options, target_files)
  if command_options['l']
    file_details = []
    target_files.each do |file_name|
      stat = File.lstat(file_name)
      file_mode = stat.mode.to_s(8)
      file_mode = file_mode[0] == '1' ? file_mode : format('%06d', file_mode).to_s
      file_details << translate_mode(file_mode)
      file_details << stat.nlink.to_s
      file_details << translate_uid(stat.uid)
      file_details << translate_gid(stat.gid)
      file_details << stat.size.to_s
      file_details << translate_date(stat.mtime)
      file_details << file_name
    end
    [true, file_details]
  else
    [false, target_files]
  end
end

def calc_file_count_per_column(files, column_count)
  (files.size / column_count).ceil
end

def divide_files(option_l, parsed_files, file_count_per_column)
  if option_l
    parsed_files.each_slice(DISPLAY_DETAILS_COUNT).to_a
  else
    parsed_files.each_slice(file_count_per_column).to_a
  end
end

def format_l_option(file_details)
  formatted_file_details = []
  file_details.transpose.each.with_index do |data_list, index|
    max_str_count = data_list.max_by(&:size).size
    # ファイルサイズや日付などを右詰にしグループ名などを左詰するための処理
    formatted_file_details <<
      if [1, 4, 5].include?(index)
        data_list.map { |v| v.rjust(max_str_count) }
      else
        data_list.map { |v| v.ljust(max_str_count) }
      end
  end
  formatted_file_details.transpose
end

def format_other_option(divided_files, file_count_per_column)
  transposed_files = []
  divided_files.each do |column|
    max_str_count = column.max_by(&:size).size
    transposed_files << column.map { |v| v.ljust(max_str_count + 2) }
  end

  last_column = transposed_files.last
  (file_count_per_column - last_column.size).times { last_column << '' }

  transposed_files.transpose
end

def format_files(option_l, divided_files, file_count_per_column)
  if option_l
    format_l_option(divided_files)
  else
    format_other_option(divided_files, file_count_per_column)
  end
end

def total_blocks(target_files)
  block_count = 0
  target_files.each do |file|
    stat = File.lstat(file)
    block_count += stat.blocks
  end
  print "total #{block_count}\n"
end

def output_files(option_l, formatted_files, target_files)
  total_blocks(target_files) if option_l
  formatted_files.each do |list|
    list.each do |value|
      suffix = "\n"
      if value == list.last
        print "#{value}#{suffix}"
      else
        print "#{value}  "
      end
    end
  end
end

def ls_command
  command_options = ARGV.getopts('a', 'r', 'l')
  column_count = 3.0
  current_directory_files = target_directory_files(command_options)
  file_count_per_column = calc_file_count_per_column(current_directory_files, column_count)
  option_l, parsed_files = parse_input(command_options, current_directory_files)
  divided_files = divide_files(option_l, parsed_files, file_count_per_column)
  formatted_files = format_files(option_l, divided_files, file_count_per_column)
  output_files(option_l, formatted_files, current_directory_files)
end
ls_command
