# frozen_string_literal: true

require 'etc'
require 'optparse'

SIX_MONTH = 15_552_000
ROW_NUM = 3
ROW_MAX_WIDTH = 24

def main
  paths = distingish_options
  total_block = acquire_blocks(paths)
  file_modes = acquire_file_modes
  links = acquire_links(paths)
  names = acquire_names(paths)
  groups = acquire_groups(paths)
  sizes = acquire_sizes(paths)
  months = acquire_months(paths)
  days = acquire_days(paths)
  times = acquire_times(paths)
  files = acquire_files

  puts "total #{total_block}"
  file_modes.zip(links, names, groups, sizes, months, days, times, files).each do |row|
    puts row.join
  end
end

def distingish_options
  opt = OptionParser.new
  opt.on('-l')
  opt.parse(ARGV)
  if ARGV == ['-l']
    acquire_absolute_paths
  else
    all_files = Dir.glob('*').sort
    files_in_columns = get_transposed_all_files(all_files)
    display(files_in_columns)
    exit
  end
end

# オプションなし

def get_transposed_all_files(all_files)
  all_files.push(' ') while all_files.length % ROW_NUM != 0
  column_num = all_files.length / ROW_NUM
  transposed_files = all_files.each_slice(column_num).to_a.transpose
  transposed_files.first(column_num).each do |column|
    ROW_NUM.times do |index|
      column[index] += ' ' * (ROW_MAX_WIDTH - column[index].length)
    end
  end
end

def display(files_in_columns)
  files_in_columns.each do |column|
    puts column.join
  end
end

#-lオプションありの場合はここから

# 絶対パスの取得
def acquire_absolute_paths
  files = Dir.glob('*').sort
  current_path = Dir.getwd
  files.map do |file|
    "#{current_path}/#{file}"
  end
end

# 総ブロック数の取得
def acquire_blocks(paths)
  blocks = paths.map do |path|
    File.stat(path).blocks
  end
  blocks.sum
end

# ファイルモードの取得
def acquire_file_modes
  paths = acquire_absolute_paths
  nums = acquire_file_mode_nums(paths)
  adjusted_nums = adjust_file_mode_nums_length(nums)
  convert_to_letter(adjusted_nums)
end

def acquire_file_mode_nums(paths)
  paths.map do |path|
    format('0%o', File.stat(path).mode)
  end
end

def adjust_file_mode_nums_length(nums)
  nums.map do |num|
    if num.length < 7
      num.insert(0, '0')
    else
      num
    end
  end
end

def convert_to_letter(adjusted_nums)
  file_types_nums = { '001' => 'p', '002' => 'c', '004' => 'd', '006' => 'b', '010' => '-', '012' => 'l', '014' => 's' }
  file_permissions_nums = { '00' => '---', '01' => '--x', '02' => '-w-', '03' => '-wx', '04' => 'r--', '05' => 'r-x', '06' => 'rw-', '07' => 'rwx' }

  file_types = []
  owner_permissions = []
  group_permissions = []
  other_permissions = []

  adjust_file_mode_nums_length(adjusted_nums).each do |num|
    file_type = file_types_nums.select { |key, _value| key == num[0, 3] }
    file_types << file_type.values

    owner_permission = file_permissions_nums.select { |key, _value| key == num[3, 2] }
    owner_permissions << owner_permission.values

    group_permission = file_permissions_nums.select { |key, _value| key[1, 1] == num[5, 1] }
    group_permissions << group_permission.values

    other_permission = file_permissions_nums.select { |key, _value| key[1, 1] == num[6, 1] }
    other_permissions << other_permission.values
  end
  file_types.zip(owner_permissions, group_permissions, other_permissions).each(&:join)
end

# リンク数、ユーザー名、グループ名、ファイルサイズの取得
# 空白調整のためのメソッド
def adjust_blank(contents, blank_size_num)
  max_length = contents.max.to_s.length

  contents_with_blank = contents.map do |content|
    gap = max_length - content.to_s.length
    if gap != 0
      content.to_s.insert(0, (' ' * gap).to_s)
    else
      content.to_s
    end
  end

  contents_with_blank.map do |content|
    "#{' ' * blank_size_num} " + content.to_s
  end
end

# 以下各種情報の取得
def acquire_links(paths)
  links = paths.map do |path|
    File.stat(path).nlink
  end
  adjust_blank(links, 0)
end

def acquire_names(paths)
  users = paths.map do |path|
    Etc.getpwuid(File.stat(path).uid).name
  end
  adjust_blank(users, 0)
end

def acquire_groups(paths)
  groups = paths.map do |path|
    Etc.getgrgid(File.stat(path).gid).name
  end
  adjust_blank(groups, 1)
end

def acquire_sizes(paths)
  sizes = paths.map do |path|
    File.stat(path).size
  end
  adjust_blank(sizes, 1)
end

def acquire_months(paths)
  paths.map do |path|
    month = File.stat(path).mtime.mon
    month.to_s.rjust(3)
  end
end

def acquire_days(paths)
  paths.map do |path|
    day = File.stat(path).mtime.mday
    day.to_s.rjust(3)
  end
end

def acquire_times(paths)
  detailed_times = paths.map do |path|
    File.stat(path).mtime
  end

  detailed_times.map do |detailed_time|
    today = Time.new
    time = if today - detailed_time > SIX_MONTH
             "  #{detailed_time.year}"
           else
             " #{detailed_time.strftime('%H:%M')}"
           end
    time.to_s.rjust(6)
  end
end

def acquire_files
  Dir.glob('*').sort.map do |file|
    " #{file}"
  end
end

main
