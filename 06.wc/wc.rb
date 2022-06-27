# frozen_string_literal: true

require 'optparse'

MAX_WIDTH = 8

def main
  params = ARGV.getopts('clw')
  files = ARGV
  if ARGV.empty?
    display_standard_input(params)
  else
    display(params, files)
  end
end

def display_standard_input(params)
  if params.values.any? == false
    exec_standard_input_with_no_option
  else
    exec_standard_input_with_options(params)
  end
end

def display(params, files)
  if params.values.any? == false
    exec_no_option(files)
  else
    exec_options(params, files)
  end
end

def exec_standard_input_with_no_option
  standard_input = $stdin.read
  puts [
    standard_input.count("\n").to_s.rjust(MAX_WIDTH),
    standard_input.split(/\s+/).size.to_s.rjust(MAX_WIDTH),
    standard_input.bytesize.to_s.rjust(MAX_WIDTH)
  ].join
end

def exec_standard_input_with_options(params)
  standard_input = $stdin.read
  stats = []
  stats = stats << standard_input.count("\n").to_s.rjust(MAX_WIDTH) if params['l']
  stats = stats << standard_input.split(/\s+/).size.to_s.rjust(MAX_WIDTH) if params['w']
  stats = stats << standard_input.bytesize.to_s.rjust(MAX_WIDTH) if params['c']
  puts stats.join
end

def exec_no_option(files)
  stats = [
    string_of_num_of_lines(files),
    string_of_num_of_words(files),
    string_of_size_of_file(files),
    file_name(files)
  ]

  stats.transpose.each do |stat|
    puts stat.join
  end

  no_option_total(files) if files.length > 1
end

def exec_options(params, files)
  stats = []
  stats = stats << string_of_num_of_lines(files) if params['l']
  stats = stats << string_of_num_of_words(files) if params['w']
  stats = stats << string_of_size_of_file(files) if params['c']
  stats = stats << file_name(files)
  stats.transpose.each do |stat|
    puts stat.join
  end
  options_total(files, params) if files.length > 1
end

def num_of_lines(files)
  files.map { |file| File.open(file).read.count("\n") }
end

def num_of_words(files)
  files.map { |file| File.open(file).read.split(/\s+/).size }
end

def num_of_size_of_file(files)
  files.map { |file| File.open(file).read.bytesize }
end

def file_name(files)
  files.map { |file| " #{file}" }
end

def string_of_num_of_lines(files)
  num_of_lines(files).map { |file| file.to_s.rjust(MAX_WIDTH) }
end

def string_of_num_of_words(files)
  num_of_words(files).map { |file| file.to_s.rjust(MAX_WIDTH) }
end

def string_of_size_of_file(files)
  num_of_size_of_file(files).map { |file| file.to_s.rjust(MAX_WIDTH) }
end

def no_option_total(files)
  puts "#{[
    num_of_lines(files).sum.to_s.rjust(MAX_WIDTH),
    num_of_words(files).sum.to_s.rjust(MAX_WIDTH),
    num_of_size_of_file(files).sum.to_s.rjust(MAX_WIDTH)
  ].join} total"
end

def options_total(files, params)
  totals = []
  totals = totals << num_of_lines(files).sum.to_s.rjust(MAX_WIDTH) if params['l']
  totals = totals << num_of_words(files).sum.to_s.rjust(MAX_WIDTH) if params['w']
  totals = totals << size_of_file(files).sum.to_s.rjust(MAX_WIDTH) if params['c']

  puts "#{totals.join} total"
end

main
