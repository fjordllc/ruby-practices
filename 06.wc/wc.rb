require 'optparse'

MAX_WIDTH = 8

def main
  params = ARGV.getopts('clw')
  files = ARGV
  display(params, files)
end

def display(params, files)
  if params.values.any? == false
    exec_no_option(files)
  else
    exec_options(params, files)
  end
end

def exec_no_option(files)
  num_of_lines = acquire_num_of_lines(files)
  num_of_words = acquire_num_of_words(files)
  size_of_file = acquire_size_of_file(files)
  file_name = acquire_file_name(files)
  num_of_lines.zip(num_of_words, size_of_file, file_name).each do |row|
    puts row.join
  end
  no_option_total(files) if files.length > 1
end

def exec_options(params, files)
  stats = []
  stats = stats << acquire_num_of_lines(files) if params['l']
  stats = stats << acquire_num_of_words(files) if params['w']
  stats = stats << acquire_size_of_file(files) if params['c']
  stats = stats << acquire_file_name(files)
  stats.transpose.each do |stat|
    puts stat.join
  end
end

def acquire_num_of_lines(files)
  files.map { |file| File.open(file).read.count("\n").to_s.rjust(MAX_WIDTH) }
end

def acquire_num_of_words(files)
  files.map { |file| File.open(file).read.split(/\s+/).size.to_s.rjust(MAX_WIDTH) }
end

def acquire_size_of_file(files)
  files.map { |file| File::Stat.new(file).size.to_s.rjust(MAX_WIDTH) }
end

def acquire_file_name(files)
  files.map { |file| " #{file}" }
end

def no_option_total(files)
  num_of_lines = files.map { |file| File.open(file).read.count("\n") }
  num_of_words = files.map { |file| File.open(file).read.split(/\s+/).size }
  num_of_sizes = files.map { |file| File::Stat.new(file).size }

  puts "#{num_of_lines.sum.to_s.rjust(MAX_WIDTH)}#{num_of_words.sum.to_s.rjust(MAX_WIDTH)}#{num_of_sizes.sum.to_s.rjust(MAX_WIDTH)} total"
end

main
