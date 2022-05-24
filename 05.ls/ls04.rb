# frozen_string_literal: true

require 'etc'

SIX_MONTH = 15_552_000

def main
  paths = get_path
  permissions = get_permission(paths)

  total_block = get_blocks(paths)

  final_permission = distingish_permission(permissions)
  links = get_link(paths)
  names = get_name(paths)
  groups = get_group(paths)
  sizes = get_size(paths)
  months = get_month(paths)
  days = get_day(paths)
  times = get_time(paths) 
  files = get_file


  total_block
 final_permission.zip(links, names,groups,sizes,months,days,times,files).each do |display|
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
  new_file_mode = []
  file_mode = paths.map do |path|
   modes = '0%o' % File.stat(path).mode
  end
  file_mode.map do |number|
    number.insert(0, '0') if number.length < 7
  end
  new_file_mode << file_mode
new_file_mode
end


def distingish_permission(permission)
  file_types = {"001" => "p", "002" => "c", "004" => "d", "006" => "b", "010" => "-", "012" => "l", "014" => "s"}
  file_permissions = {"00" => "---", "01" => "--x", "02" => "-w-", "03" => "-wx", "04" => "r--", "05" => "r-x", "06" => "rw-", "07" => "rwx"}

  parts1 = []
  parts2 = []
  parts3 = []
  parts4 = []

  permission.each do |numbers|
    numbers.each do |num|
    a = file_types.select {|key,value| key == num[0, 3]}
    parts1 << a.values

    b = file_permissions.select {|key,value| key == num[3, 2]}
    parts2 << b.values

    c = file_permissions.select {|key,value| key[1,1] == num[5, 1]}
    parts3 << c.values

    d = file_permissions.select {|key,value| key[1,1] == num[6, 1]}
    parts4 << d.values
    end
  end

  parts1.zip(parts2, parts3, parts4).each do |display|
    display.join
  end
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
