# frozen_string_literal: true

require 'optparse'
require 'debug'

MAX_WIDTH = 8

def main
  params = ARGV.getopts('clw')
  files = ARGV
  files_content = read_file(files)
  exec_options(params, files, files_content)
end


def exec_options(params, files, files_content)
  params = {"c"=> true, "l"=> true, "w"=> true} if params.values.any? == false
  stats = []
  stats = stats << string_of_num_of_lines(files_content) if params['l']
  stats = stats << string_of_num_of_words(files_content) if params['w']
  stats = stats << string_of_size_of_file(files_content) if params['c']
  stats = stats << file_name(files)

  if ARGV.empty?
    puts stats.join
  else
    stats.transpose.each do |stat|
      puts stat.join
    end
  end
  options_total(files, params) if files.length > 1
end

def read_file(files)
  if ARGV.empty?
    $stdin.read
  else
    files.map { |file| File.open(file).read }
  end
end

def num_of_lines(files_content)
  if files_content.class == String
    files_content.count("\n")
  else
    files_content.map { |content| content.count("\n") }
  end
end

def num_of_words(files_content)
  if files_content.class == String
    files_content.split(/\s+/).size
  else
    files_content.map { |content| content.split(/\s+/).size }
  end
end

def num_of_size_of_file(files_content)
  if files_content.class == String
    files_content.bytesize
  else
    files_content.map { |content| content.bytesize}
  end
end

def file_name(files)
  files.map { |file| " #{file}" }
end

def string_of_num_of_lines(files_content)
  if files_content.class == String
    files_content.count("\n").to_s.rjust(MAX_WIDTH)
  else
    num_of_lines(files_content).map { |num| num.to_s.rjust(MAX_WIDTH)}
  end
end

def string_of_num_of_words(files_content)
  if files_content.class == String
    num_of_words(files_content).to_s.rjust(MAX_WIDTH)
  else
    num_of_words(files_content).map { |num| num.to_s.rjust(MAX_WIDTH)}
  end
end

def string_of_size_of_file(files_content)
  if files_content.class == String
    num_of_size_of_file(files_content).to_s.rjust(MAX_WIDTH)
  else
    num_of_size_of_file(files_content).map { |num| num.to_s.rjust(MAX_WIDTH)}
  end 
end


def options_total(files, params)
  totals = []
  totals = totals << num_of_lines(files).sum.to_s.rjust(MAX_WIDTH) if params['l']
  totals = totals << num_of_words(files).sum.to_s.rjust(MAX_WIDTH) if params['w']
  totals = totals << num_of_size_of_file(files).sum.to_s.rjust(MAX_WIDTH) if params['c']

  puts "#{totals.join} total"
end

main
