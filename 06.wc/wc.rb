require 'optparse'

def main
  files = ARGV
  params = ARGV.getopts('clw')
  display(files)
end

def acquire_num_of_lines(files)
  files.map do |file|
    content = File.open(file).read
    content.count("\n").to_s.rjust(8)
  end
end

def acquire_num_of_words(files)
  files.map do |file|
    content = File.open(file).read
    content.split(/\s+/).size.to_s.rjust(8)
  end
end

def acquire_size_of_file(files)
  files.map do |file|
    content = File.open(file).read
    File::Stat.new(file).size.to_s.rjust(8)
  end
end

def acquire_file_name(files)
  files.map do |file|
    " #{file}"
  end
end

def display(files)
  num_of_lines = acquire_num_of_lines(files)
  num_of_words = acquire_num_of_words(files)
  size_of_file = acquire_size_of_file(files)
  file_name = acquire_file_name(files)
  num_of_lines.zip(num_of_words, size_of_file, file_name).each do |row|
    puts row.join
  end
end

main
