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
  puts blocks_total.sum
end

current_pass = Dir.getwd 
  files = Dir.glob('*').sort
  file_mode = []
  files.each do |file|
    pass = current_pass + '/' + file
    stat = File.stat(pass)
    modes = "0%o" % stat.mode
    file_mode << modes
  end
  
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
  

  puts parts1 + parts2 + parts3 + parts4
end
 




