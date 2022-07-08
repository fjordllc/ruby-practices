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
  params = { 'c' => true, 'l' => true, 'w' => true } unless params.values.any?

  num_of_lines = num_of_lines(files_content)
  num_of_words = num_of_words(files_content)
  num_of_size_of_file = num_of_size_of_file(files_content)

  stats = []
  stats = stats << convert_to_string(num_of_lines) if params['l']
  stats = stats << convert_to_string(num_of_words) if params['w']
  stats = stats << convert_to_string(num_of_size_of_file) if params['c']
  stats << file_name(files) unless files.empty?
  stats
end

def display(stats, files, params, files_content)
  stats.transpose.each do |stat|
    puts stat.join
  end
  options_total(params, files_content) if files.length > 1
end

def read_file(files)
  if ARGV.empty?
    [$stdin.read]
  else
    files.map { |file| File.open(file).read }
  end
end

def num_of_lines(files_content)
  files_content.map { |content| content.count("\n") }
end

def num_of_words(files_content)
  files_content.map { |content| content.split(/\s+/).size }
end

def num_of_size_of_file(files_content)
  files_content.map(&:bytesize)
end

def file_name(files)
  files.map { |file| " #{file}" }
end

def convert_to_string(stat_nums)
  stat_nums.map { |stat_num| stat_num.to_s.rjust(MAX_WIDTH) }
end

def options_total(params, files_content)
  params = { 'c' => true, 'l' => true, 'w' => true } unless params.values.any?
  totals = [%w[lines l], %w[words w], %w[size_of_file c]].map do |name, opt|
    send("num_of_#{name}", files_content).sum.to_s.rjust(MAX_WIDTH) if params[opt]
  end
  puts "#{totals.join} total"
end
main
