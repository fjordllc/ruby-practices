# frozen_string_literal: true

require 'etc'
require 'optparse'

SIX_MONTH = 15_552_000
ROW_NUM = 3
ROW_MAX_WIDTH = 24

def main
  params = ARGV.getopts('alr')
  all_files = get_all_files(params)
  exec_option(params, all_files)
end

def get_all_files(params)
  if params ['a'] && params ['r']
    Dir.glob('*', File::FNM_DOTMATCH).sort.reverse
  elsif params ['a']
    Dir.glob('*', File::FNM_DOTMATCH).sort
  elsif params ['r']
    Dir.glob('*').sort.reverse
  else
    Dir.glob('*').sort
  end
end

def exec_option(params, all_files)
  if params['l']
    exec_l_option(all_files)
  else
    exec_other_options(all_files)
  end
end

def exec_l_option(all_files)
  files_info = acquire_file_info(all_files)
  total_block = acquire_total_block(files_info)
  puts "total #{total_block}"
  display_outcome_of_l_option(files_info, all_files)
end

def exec_other_options(all_files)
  files_in_columns = get_transposed_all_files(all_files)
  display_outcome_of_no_option(files_in_columns)
end

def acquire_file_info(all_files)
  all_files.map { |file| File.stat(file) }
end

def acquire_total_block(files_info)
  files_info.map(&:blocks).sum
end

def display_outcome_of_l_option(files_info, all_files)
  file_modes = acquire_file_modes(files_info)
  links = acquire_links(files_info)
  names = acquire_names(files_info)
  groups = acquire_groups(files_info)
  sizes = acquire_sizes(files_info)
  months = acquire_months(files_info)
  days = acquire_days(files_info)
  times = acquire_times(files_info)
  files = all_files.map { |file| " #{file}" }

  file_modes.zip(links, names, groups, sizes, months, days, times, files).each do |row|
    puts row.join
  end
end

def acquire_file_modes(file_info)
  mode_nums = file_info.map { |file| format('0%o', file.mode) }
  convert_to_letter(mode_nums)
end

def file_types_nums
  {
    '001' => 'p',
    '002' => 'c',
    '004' => 'd',
    '006' => 'b',
    '010' => '-',
    '012' => 'l',
    '014' => 's'
  }
end

def file_permissions_nums
  {
    '00' => '---',
    '01' => '--x',
    '02' => '-w-',
    '03' => '-wx',
    '04' => 'r--',
    '05' => 'r-x',
    '06' => 'rw-',
    '07' => 'rwx'
  }
end

def convert_to_letter(mode_nums)
  formatted_nums = mode_nums.map { |num| num.rjust(7, '0') }

  file_types = formatted_nums.map { |num| file_types_nums[(num[0, 3]).to_s] }
  owner_permissions = formatted_nums.map { |num| file_permissions_nums[num[3, 2].to_s] }
  group_permissions = formatted_nums.map { |num| file_permissions_nums["0#{num[5, 1]}"] }
  other_permissions = formatted_nums.map { |num| file_permissions_nums["0#{num[6, 1]}"] }

  file_types.zip(owner_permissions, group_permissions, other_permissions).each(&:join)
end

def adjust_blank(contents, blank_size_num)
  max_length = contents.max.to_s.length
  contents.map do |content|
    content.to_s.rjust(max_length + blank_size_num, ' ')
  end
end

def acquire_links(files_info)
  links = files_info.map(&:nlink)
  adjust_blank(links, 1)
end

def acquire_names(files_info)
  users = files_info.map { |file| Etc.getpwuid(file.uid).name }
  adjust_blank(users, 1)
end

def acquire_groups(files_info)
  groups = files_info.map { |file| Etc.getgrgid(file.gid).name }
  adjust_blank(groups, 2)
end

def acquire_sizes(files_info)
  sizes = files_info.map(&:size)
  adjust_blank(sizes, 2)
end

def acquire_months(files_info)
  months = files_info.map { |file| file.mtime.mon }
  adjust_blank(months, 1)
end

def acquire_days(files_info)
  days = files_info.map { |file| file.mtime.mday }
  adjust_blank(days, 1)
end

def acquire_times(files_info)
  detailed_times = files_info.map(&:mtime)
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

def display_outcome_of_no_option(files_in_columns)
  files_in_columns.each do |column|
    puts column.join
  end
end

main
