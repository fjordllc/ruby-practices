# frozen_string_literal: true

require_relative 'filestat_constants'
require 'etc'
require 'optparse'
opt = OptionParser.new
params = {}

opt.on('-l') { |v| v }

opt.parse!(ARGV, into: params)
target_name = ARGV[0] || '.'
target_path = File.expand_path(target_name)

MAX_NUMBER_OF_COLUMNS = 3

def main(target_contents, params, directory_flag)
  display_width = calculate_display_width(target_contents)
  array_for_display = create_array_for_display(target_contents, params)
  print_filename(array_for_display, display_width, params, directory_flag)
end

def calculate_display_width(target_contents)
  filename_length_array = target_contents.map do |filename|
    # 非ascii文字は表示幅が+1になる
    filename.to_s.length + filename.to_s.chars.count { |x| !x.ascii_only? }
  end
  filename_length_array.max + 5
end

def create_array_for_display(target_contents, params)
  display_columns = params[:l] == true ? 1 : MAX_NUMBER_OF_COLUMNS

  # 等差数列で表示するための公差(common difference)を求める
  common_difference = (target_contents.length / display_columns.to_f).ceil

  target_contents_divided_per_common_difference =
    target_contents.each_slice(common_difference).to_a

  Array.new(common_difference) do
    target_contents_divided_per_common_difference.map(&:shift)
  end
end

def print_filename(array_for_display, display_width, params, directory_flag)
  # ブロック数を表示
  puts "total #{array_for_display.shift[0]}" if params[:l] && directory_flag

  array_for_display.each do |row|
    row.each do |file|
      number_of_not_ascii_character = file&.chars&.count { |x| !x.ascii_only? }
      print file&.ljust(display_width - number_of_not_ascii_character)
    end
    puts "\n"
  end
end

def convert_long_format(contents_array, target_path, directory_flag)
  file_blocks = sum_file_blocks(contents_array, target_path)
  contents_array = to_long_format(contents_array, target_path)
  return contents_array unless directory_flag

  contents_array.unshift(file_blocks)
end

def sum_file_blocks(contents_array, target_path)
  contents_array.map do |file|
    File.lstat("#{target_path}/#{file}").blocks
  end.sum
end

def to_long_format(contents_array, target_path)
  contents_array.map do |file|
    fs = File.lstat("#{target_path}/#{file}")

    mode = fs.mode.to_s(8).rjust(6, '0')
    filetype = FILETYPE[mode[0..1]]
    special_permission = SPECIAL_PERMISSION[mode[2]]
    permission = mode[3..5].chars
                           .map { |modevalue| PERMISSION[modevalue] }
                           .join
    apply_special_permission(special_permission, permission)
    mode = "#{filetype}#{permission}"

    links = fs.nlink.to_s.rjust(2)
    uname = Etc.getpwuid(fs.uid).name
    gname = Etc.getgrgid(fs.gid).name
    size = fs.size.to_s.rjust(5)
    datetime = fs.mtime.strftime('%m %e %R')
    symlink = "-> #{File.readlink("#{target_path}/#{file}")}" if filetype == 'l'

    "#{mode}  #{links} #{uname}  #{gname} #{size} #{datetime} #{file} #{symlink}"
  end
end

def apply_special_permission(special_permission, permission)
  return if special_permission == 'none'

  case special_permission
  when 'stickybit'
    permission[8] = permission[8] == 'x' ? 't' : 'T'
  when 'sgid'
    permission[5] = permission[5] == 'x' ? 's' : 'S'
  when 'suid'
    permission[2] = permission[2] == 'x' ? 's' : 'S'
  end
end

def get_target_contents(target_name)
  if File.ftype(target_name) == 'directory'
    Dir.glob('*', base: target_name).sort
  else
    [File.basename(target_name)]
  end
end

directory_flag = File.ftype(target_path) == 'directory'
target_path.gsub!(%r{/#{File.basename(target_path)}}, '') unless directory_flag

target_contents = get_target_contents(target_name)
target_contents = convert_long_format(target_contents, target_path, directory_flag) if params[:l]

main(target_contents, params, directory_flag)
