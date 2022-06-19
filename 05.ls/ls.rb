# frozen_string_literal: true

def get_files(path)
  files = path ? Dir.entries(path) - %w[. ..] : Dir.entries('.') - %w[. ..]
  files = files.sort
  files.filter { |file| file&.chr != '.' }
end

def print_files(file_name)
  files = get_files(file_name)
  # カラムを変更する変数
  columns = 3
  number_row = files.length % columns ? files.length / columns + 1 : files.length
  tab_files = files.each_slice(number_row).to_a
  (0..(number_row - 1)).each do |i|
    lines = tab_files.map { |file| file[i]&.slice(0, 15)&.ljust(20) unless file[i].nil? }.compact
    puts lines.join('')
  end
end
print_files(ARGV[0])
