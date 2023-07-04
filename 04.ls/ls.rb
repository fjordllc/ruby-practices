# frozen_string_literal: true

current_directory = Dir.pwd
file = Dir.entries(current_directory)
files = []
file.each do |x|
  next if x.match?(/^\./)

  files.push(x)
end

col_num = 3
row_num = (files.size / col_num.to_f).ceil

cols = [*0..col_num - 1]
rows = [*0..row_num - 1]
nothing_option = files.sort
rows.each do |row|
  cols.each do |col|
    break if nothing_option[row + col * rows.size].nil?

    print nothing_option[row + col * rows.size].ljust(26)
  end

  puts
end
