require "debug"

current_directory = Dir.pwd
file = Dir::entries("#{current_directory}")
files = []
file.each do |x|
  next if x.match?(/^\./)
  files.push(x)
end

cols = [*0..4]
rows = [*0..((files.size / 5.0).ceil-1)]
nothing_option = files.sort
rows.each do |row|
  cols.each do |col|
    if rows.size == 1
      print files[ row + col ]
    else
      print nothing_option[ row + col * 5 ]
    end
  end
  
  puts
end
