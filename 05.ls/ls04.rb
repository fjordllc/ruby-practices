require 'etc'

def total_blocks
  files = Dir.glob('*').sort
  blocks_total = files.map { |file|
    path = Dir.getwd + '/' + file
    blocks = File.stat(path).blocks
}
  puts "total #{blocks_total.sum}"
end

def get_permission
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  file_mode = []

  files.each do |file|
    path = current_pass + '/' + file
    modes = "0%o" % File.stat(path).mode
    file_mode << modes
  end

  new_file_mode = []
file_mode.each do |number|
  number.insert(0, "0") if number.length < 7

  if number[0,3] == "004"
    parts1 = "d" 
  elsif number[0,3] == "010"
    parts1 =  "-" 
  end

  if number[3,2] == "06"
    parts2 = "rw-" 
  elsif number[3,2] == "07"
    parts2 =  "rwx" 
  end

  if number[5,1] == "0"
    parts3 = "---" 
  elsif number[5,1] == "4"
    parts3 = "r--"
  elsif number[5,1] == "5"
    parts3 =  "r-x" 
  end

  if number[6,1] == "0"
    parts4 = "---" 
  elsif number[6,1] == "4"
    parts4 = "r--"
  elsif number[6,1] == "5"
    parts4 =  "r-x" 
  end

  new_mode = parts1 + parts2 + parts3 + parts4 + " "
  new_file_mode << new_mode
end
new_file_mode
end

def get_link
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  links_sizes = []

  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    links = stat.nlink 
    links_sizes << links 
  end

  max_length = links_sizes.max.to_s.length
  new_links_sizes = []

    links_sizes.each do |size|
      gap = max_length - size.to_s.length
      if gap != 0
      a = size.to_s.insert(0, "#{" " * gap}")
      else
        a = size
      end
      new_links_sizes << a
    end

  new_links_sizes
end

def get_name
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  users_total = []
  files.each do |file|
    path = current_pass + '/' + file
    users = Etc.getpwuid(File.stat(path).uid).name
    users_total << users
  end

  max_length = users_total.max.to_s.length
  new_users_total = []

  users_total.each do |user|
      gap = max_length - user.to_s.length
      if gap != 0
      a = user.to_s.insert(0, "#{" " * gap}")
      else
      a = user
      end
      new_users_total << " " + a + " "
    end

  new_users_total

end

def get_group
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  groups_total = []
  files.each do |file|
    path = current_pass + '/' + file
    groups = Etc.getgrgid(File.stat(path).gid).name
    groups_total << groups
  end
    max_length = groups_total.max.to_s.length
    new_groups = []

    groups_total.each do |group|
        gap = max_length - group.to_s.length
        if gap != 0
        a = group.to_s.insert(0, "#{" " * gap}")
        else
        a = group
        end
        new_groups << " " + a + " "
      end

    new_groups

end

def get_size
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  sizes_total = []
  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    sizes = stat.size
    sizes_total << sizes
  end

  max_length = sizes_total.max.to_s.length
  new_sizes_total = []

  sizes_total.each do |size|
      gap = max_length - size.to_s.length
      if gap != 0
      a = size.to_s.insert(0, "#{" " * gap}")
      else
      a = size
      end
      new_sizes_total << " " + a.to_s
    end

    new_sizes_total

end

def get_month
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  months = []
  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    month = stat.mtime.mon
    months << month
  end

  max_length = months.max.to_s.length
  new_months = []

  months.each do |month|
      gap = max_length - month.to_s.length
      if gap != 0
      a = month.to_s.insert(0, "#{" " * gap}")
      else
      a = month
      end
      new_months << " " + a.to_s
    end

  new_months
end

def get_day
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  days = []
  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    day = stat.mtime.mday
    days << day
  end

  max_length = days.max.to_s.length
  new_days = []

  days.each do |day|
      gap = max_length - day.to_s.length
      if gap != 0
      a = day.to_s.insert(0, "#{" " * gap}")
      else
      a = day
      end
      new_days << " " + a.to_s
    end

  new_days
end

def get_time
  current_pass = Dir.getwd
  files = Dir.glob('*').sort

  times = []
  files.each do |file|
    pass = "#{current_pass}/#{file}"
    stat = File.stat(pass)
    time = stat.mtime
    times << time
  end

  hours = []
  mins = []
  years = []
  new_times = []
  times.each do |time|
    hours << time.hour
    mins << time.min
    years << time.year
  end

  hours_max_length = hours.max.to_s.length
  new_hours = []
  hours.each do |hour|
    gap = hours_max_length - hour.to_s.length
      a = if gap != 0
            hour.to_s.insert(0, '0').to_s
          else
            hour
          end
      new_hours << " #{a.to_s}"
  end

  mins_max_length = mins.max.to_s.length
  new_mins = []
  mins.each do |min|
    gap = mins_max_length - min.to_s.length
       a = if gap != 0
            min.to_s.insert(0, '0').to_s
          else
            min
          end
    new_mins << a.to_s
  end

 
  total_hours_mins =[]
  a = new_hours.zip(new_mins)
    a.each do |display|
      total_hours_mins << display.join(':')
    end

     new_times = []

  times.each do |time|
    today = Time.new
    six_month = 15_552_000
    if today - time > six_month
      final_time = "  #{time.year}"
    else
      total_hours_mins.map do |x|
        final_time = x
      end
    end
    new_times << final_time
  end

  new_times
    
end


def get_file
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  new_files = []

  files.each do |file|
      new_files << " " + file
  end
  new_files
end

def main
  permission = get_permission
  link = get_link
  name = get_name
  group = get_group
  size = get_size
  month = get_month
  day = get_day
  time = get_time
  file = get_file


  total_blocks

  a = permission.zip(link,name,group,size,month,day,time,file)
  a.each do |display|
    puts display.join
  end
end

main

