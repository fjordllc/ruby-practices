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
  hours = get_hour(paths)
  mins = get_min(paths)
  times = get_time(hours, mins)
  files = get_file

  total_blocks
  a = permission.zip(links, names,groups,sizes,months,days,times, files)
  a.each do |display|
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

def adjust_blank(sizes, blank_input)
  max_length = sizes.max.to_s.length
  with_blank_ = sizes.map do |size|
    gap = max_length - size.to_s.length
    a = if gap != 0
          size.to_s.insert(0, (blank_input * gap).to_s)
        else
          size.to_s
        end
  end
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
  
  final = []
  blanks = adjust_blank(links_sizes, " ")
  blanks.each do |blank|
    final <<  " " + "#{blank}"
  end
  final
end

def get_name(paths)
  users_total = paths.map do |path|
    users = Etc.getpwuid(File.stat(path).uid).name
  end
  final = []
  blanks = adjust_blank(users_total, " ")
  blanks.each do |blank|
    final <<  " " + "#{blank}"
  end
  final
end

def get_group(paths)
 groups_total = paths.map do |path|
    groups = Etc.getgrgid(File.stat(path).gid).name
  end
  final = []
  blanks = adjust_blank(groups_total, " ")
  blanks.each do |blank|
    final <<  "  " + "#{blank}"
  end
  final
end

def get_size(paths)
  sizes_total = paths.map do |path|
     sizes = File.stat(path).size
   end
   final = []
   blanks = adjust_blank(sizes_total, " ")
   blanks.each do |blank|
    final <<  "  " + "#{blank}"
  end
   final
 end

def get_month(paths)
  months_total = paths.map do |path|
    months = File.stat(path).mtime.mon
  end
  final = []
  blanks = adjust_blank(months_total, " ")
  blanks.each do |blank|
   final <<  " " + "#{blank}"
 end
  final

end

def get_day(paths)
  days_total = paths.map do |path|
    days = File.stat(path).mtime.mday
  end
  final = []
  blanks = adjust_blank(days_total, " ")
  blanks.each do |blank|
   final <<  " " + "#{blank}"
 end
  final

end

def get_hour(paths)
  hours_total = paths.map do |path|
    hours = File.stat(path).mtime.hour
  end
  blank = adjust_blank(hours_total, "0")
  blank
end

def get_min(paths)
  mins_total = paths.map do |path|
    hours = File.stat(path).mtime.min
  end
  blank = adjust_blank(mins_total, "0")
  blank
end

def get_time(hours, mins)
  newtimes = hours.zip(mins).map do |time|
     time.join(":")
  end
  final = []
  blanks = adjust_blank(newtimes, " ")
  blanks.each do |blank|
   final <<  " " + "#{blank}"
 end
  final

end

def get_file
  new_files = Dir.glob('*').sort.map do |file|
    " " + "#{file}"
  end
end

main


# def time_or_year(paths,times)
#   time_details = paths.map do |path|
#     File.stat(path).mtime
#   end

# new_times = []
# today = Time.new
  
#   time_details.each do |detail|
#     if today - detail > SIX_MONTH
#        display = " #{detail.year}"
#     else
#       times.each do |time|
#         display = "none"
#       end
#     end
#     new_times << display
#   end
#   new_times
# end