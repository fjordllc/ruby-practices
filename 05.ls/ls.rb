# frozen_string_literal: true

def get_files
  files = Dir.glob("*")
  files = files.sort
end

def print_files
  files = get_files
  # カラムを変更する変数
  columns = 3
  number_of_rows = (files.length % columns).zero? ? files.length / columns : files.length / columns + 1 
  tab_files = files.each_slice(number_of_rows).to_a
  number_of_rows.times do |i|
    lines = tab_files.map { |file| file[i]&.slice(0, 15)&.ljust(20) unless file[i].nil? }.compact
    puts lines.join('')
  end
end
print_files
