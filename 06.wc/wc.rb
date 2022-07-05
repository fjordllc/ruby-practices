# frozen_string_literal: true

require 'optparse'

MAX_WIDTH = 8

def main
  params = ARGV.getopts('clw')
  files = ARGV
  files_content = read_file(files)
  stats = exec(params, files, files_content)
  display(stats, files, params, files_content)
end

def exec(params, files, files_content)
  params = { 'c' => true, 'l' => true, 'w' => true } if params.values.any? == false

  num_of_lines = num_of_lines(files_content)
  num_of_words = num_of_words(files_content)
  num_of_size_of_file = num_of_size_of_file(files_content)

  stats = []
  stats = stats << convert_to_string(num_of_lines, files_content) if params['l']
  stats = stats << convert_to_string(num_of_words, files_content) if params['w']
  stats = stats << convert_to_string(num_of_size_of_file, files_content) if params['c']
  stats << file_name(files)
end

def display(stats, files, params, files_content)
  if ARGV.empty?
    puts stats.join
  else
    stats.transpose.each do |stat|
      puts stat.join
    end
  end
  options_total(params, files_content) if files.length > 1
end

def read_file(files)
  if ARGV.empty?
    $stdin.read
  else
    files.map { |file| File.open(file).read }
  end
end

def num_of_lines(files_content)
  if files_content.instance_of?(String)
    files_content.count("\n")
  else
    files_content.map { |content| content.count("\n") }
  end
end

def num_of_words(files_content)
  if files_content.instance_of?(String)
    files_content.split(/\s+/).size
  else
    files_content.map { |content| content.split(/\s+/).size }
  end
end

def num_of_size_of_file(files_content)
  if files_content.instance_of?(String)
    files_content.bytesize
  else
    files_content.map(&:bytesize)
  end
end

def file_name(files)
  files.map { |file| " #{file}" }
end

def convert_to_string(stat, files_content)
  if files_content.instance_of?(String)
    stat.to_s.rjust(MAX_WIDTH)
  else
    stat.map { |num| num.to_s.rjust(MAX_WIDTH) }
  end
end

def options_total(params, files_content)
  params = { 'c' => true, 'l' => true, 'w' => true } if params.values.any? == false
  totals = []
  totals = totals << num_of_lines(files_content).sum.to_s.rjust(MAX_WIDTH) if params['l']
  totals = totals << num_of_words(files_content).sum.to_s.rjust(MAX_WIDTH) if params['w']
  totals = totals << num_of_size_of_file(files_content).sum.to_s.rjust(MAX_WIDTH) if params['c']

  puts "#{totals.join} total"
end

main
