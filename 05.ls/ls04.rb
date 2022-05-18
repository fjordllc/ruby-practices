require 'etc'

def total_blocks
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  blocks_total = []
  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    blocks = stat.blocks
    blocks_total << blocks
  end
  puts "total #{blocks_total.sum}"
end

def get_permission
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  file_mode = []
  
  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    modes = "0%o" % stat.mode
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
  
  new_mode = parts1 + parts2 + parts3 + parts4
  new_file_mode << new_mode
end
new_file_mode
end

def get_link
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  links_total = []
  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    links = stat.nlink
    links_total << links
  end
  links_total

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
  users_total
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
  groups_total
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
  sizes_total
end
  
def get_time
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  times_total = []
  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    month = stat.mtime.mon
    day = stat.mtime.mday
    hour = stat.mtime.hour
    min = stat.mtime.min
    times = "#{month} #{day} #{hour}:#{min}"
    times_total << times
  end
  times_total
end

def get_file
  current_pass = Dir.getwd 
  files = Dir.glob('*').sort

end

def main
  permission = get_permission
  link = get_link
  name = get_name
  group = get_group
  size = get_size
  time = get_time
  file = get_file

  total_blocks
  a = permission.zip(link,name,group,size,time,file)
  a.each do |display|
    puts display.join
  end
end

main
  


