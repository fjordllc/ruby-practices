require 'optparse'

MAX_WIDTH = 8

def main
  params = ARGV.getopts('clw')
  files = ARGV
  info = acquire_info(files, params)
  display(params, info, files)
  total(files) if files.length > 1
end

def acquire_info(files, params)
  files = files.map { |file| }

  files = File.open(file).read.count("\n") if params['l']
  files = File.open(file).read.split(/\s+/).size if params['w']
  files = File::Stat.new(file).size if params['c']

  files
end

def display(params, _info, files)
  if params['l']
    exec_l_option(files)
  else
    exec_no_option(files)
  end
end

def exec_l_option(files)
  files.map { |file| File.open(file).read.count("\n").to_s.rjust(MAX_WIDTH) }
end

def exec_w_option(files)
  files.map { |file| File.open(file).read.split(/\s+/).size.to_s.rjust(MAX_WIDTH) }
end

def exec_c_option(files)
  files.map { |file| File::Stat.new(file).size.to_s.rjust(MAX_WIDTH) }
end

def acquire_file_name(files)
  files.map { |file| " #{file}" }
end

def exec_other_options(files)
  num_of_lines = exec_l_option(files)
  num_of_words = exec_w_option(files)
  size_of_file = exec_c_option(files)
  file_name = acquire_file_name(files)
  num_of_lines.zip(num_of_words, size_of_file, file_name).each do |row|
    puts row.join
  end
end

def exec_no_option(files)
  num_of_lines = exec_l_option(files)
  num_of_words = exec_w_option(files)
  size_of_file = exec_c_option(files)
  file_name = acquire_file_name(files)
  num_of_lines.zip(num_of_words, size_of_file, file_name).each do |row|
    puts row.join
  end
end

def total(files)
  num_of_lines = files.map { |file| File.open(file).read.count("\n") }
  num_of_words = files.map { |file| File.open(file).read.split(/\s+/).size }
  num_of_sizes = files.map { |file| File::Stat.new(file).size }

  puts "#{num_of_lines.sum.to_s.rjust(MAX_WIDTH)}#{num_of_words.sum.to_s.rjust(MAX_WIDTH)}#{num_of_sizes.sum.to_s.rjust(MAX_WIDTH)} total"
end

main
