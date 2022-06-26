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
  stats = [
    acquire_num_of_lines(files).map { |file| file.to_s.rjust(MAX_WIDTH) },
    acquire_num_of_words(files).map { |file| file.to_s.rjust(MAX_WIDTH) },
    acquire_size_of_file(files).map { |file| file.to_s.rjust(MAX_WIDTH) },
    acquire_file_name(files)
  ]
  stats.transpose.each do |stat|
    puts stat.join
  end
  no_option_total(files) if files.length > 1
end

def exec_options(params, files)
  stats = []
  stats = stats << acquire_num_of_lines(files).map { |file| file.to_s.rjust(MAX_WIDTH) } if params['l']
  stats = stats << acquire_num_of_words(files).map { |file| file.to_s.rjust(MAX_WIDTH) } if params['w']
  stats = stats << acquire_size_of_file(files).map { |file| file.to_s.rjust(MAX_WIDTH) } if params['c']
  stats = stats << acquire_file_name(files)
  stats.transpose.each do |stat|
    puts stat.join
  end
  options_total(files, params) if files.length > 1
end

def acquire_num_of_lines(files)
  files.map { |file| File.open(file).read.count("\n") }
end

def acquire_num_of_words(files)
  files.map { |file| File.open(file).read.split(/\s+/).size }
end

def acquire_size_of_file(files)
  files.map { |file| File::Stat.new(file).size }
end

def acquire_file_name(files)
  files.map { |file| " #{file}" }
end

def no_option_total(files)
  total_num_of_lines = acquire_num_of_lines(files).sum.to_s.rjust(MAX_WIDTH)
  total_num_of_words = acquire_num_of_words(files).sum.to_s.rjust(MAX_WIDTH)
  total_num_of_sizes = acquire_size_of_file(files).sum.to_s.rjust(MAX_WIDTH)

  puts "#{[total_num_of_lines, total_num_of_words, total_num_of_sizes].join} total"
end

def options_total(files, params)
  totals = []
  totals = totals << acquire_num_of_lines(files).sum.to_s.rjust(MAX_WIDTH) if params['l']
  totals = totals << acquire_num_of_words(files).sum.to_s.rjust(MAX_WIDTH) if params['w']
  totals = totals << acquire_size_of_file(files).sum.to_s.rjust(MAX_WIDTH) if params['c']

  puts "#{totals.join} total"
end

main
