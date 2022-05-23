# frozen_string_literal: true

require 'etc'

SIX_MONTH = 15_552_000

def main
  paths = get_path
  total_blocks = get_blocks(paths)
  permission = get_permission(paths)
  links = get_link(paths)
  names = get_name(paths)
  groups = get_group(paths)
  sizes = get_size(paths)
  months = get_month(paths)
  days = get_day(paths)
  times = get_time(paths) 
  files = get_file


  total_blocks
 permission.zip(links, names,groups,sizes,months,days,times,files).each do |display|
    puts display.join
  end
end

def get_path
  files = Dir.glob('*').sort
  current_path = Dir.getwd
  paths = files.map do |file|
    path = "#{current_path}/#{file}"
  end
 paths
end

def adjust_blank(sizes)
  max_length = sizes.max.to_s.length
  with_blank_ = sizes.map do |size|
  gap = max_length - size.to_s.length
    a = if gap != 0
          size.to_s.insert(0, (" " * gap).to_s)
        else
          size.to_s
        end
  end
end

def into_arrays(total,blank_size)
  final = []
 adjust_blank(total).each do |blank|
    final <<  "#{" " * blank_size} "+ "#{blank}"
  end
  final
end

def get_permission(paths)
  file_mode = paths.map do |path|
   modes = '0%o' % File.stat(path).mode
  end

  new_file_mode = []
  file_mode.each do |number|
    number.insert(0, '0') if number.length < 7

    case number[0, 3]
    when '004'
      parts1 = 'd'
    when '010'
      parts1 = '-'
    end

    case number[3, 2]
    when '06'
      parts2 = 'rw-'
    when '07'
      parts2 = 'rwx'
    end

    case number[5, 1]
    when '0'
      parts3 = '---'
    when '4'
      parts3 = 'r--'
    when '5'
      parts3 = 'r-x'
    end

    case number[6, 1]
    when '0'
      parts4 = '---'
    when '4'
      parts4 = 'r--'
    when '5'
      parts4 = 'r-x'
    end

    new_mode = "#{parts1}#{parts2}#{parts3}#{parts4} "
    new_file_mode << new_mode
  end
  new_file_mode
end


def get_blocks(paths)
  blocks_total = paths.map do |path|
    blocks = File.stat(path).blocks
  end
  puts "total #{blocks_total.sum}"
end

def get_link(paths)
  links_sizes = paths.map do |path|
    links = File.stat(path).nlink
  end

into_arrays(links_sizes, 0)
end

def get_name(paths)
  users_total = paths.map do |path|
    users = Etc.getpwuid(File.stat(path).uid).name
  end
  into_arrays(users_total, 0)
end

def get_group(paths)
 groups_total = paths.map do |path|
    groups = Etc.getgrgid(File.stat(path).gid).name
  end
  into_arrays(groups_total, 1)
end

def get_size(paths)
  sizes_total = paths.map do |path|
     sizes = File.stat(path).size
   end
   into_arrays(sizes_total, 1)
 end

def get_month(paths)
  new_month = []
  months_total = paths.map do |path|
    months = File.stat(path).mtime.mon
    new_month << months.to_s.rjust(3)
  end
  new_month

end

def get_day(paths)
  new_days = []
  days_total = paths.map do |path|
    days = File.stat(path).mtime.mday
  new_days << days.to_s.rjust(3)
  end
  new_days
end

def get_time(paths)
  time_details = paths.map do |path|
    File.stat(path).mtime
  end

new_times = []
  time_details.each do |detail|
    today = Time.new
    if today - detail > SIX_MONTH
       display = "  #{detail.year}"
    else 
       display = " #{detail.strftime("%H:%M")}"
    end
    new_times << "#{display}".rjust(6)
  end
  new_times
end

def get_file
  new_files = Dir.glob('*').sort.map do |file|
    " " + "#{file}"
  end
end

main
