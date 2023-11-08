#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def determine_options
  options = { has_line_count: false, has_word_count: false, has_char_count: false }

  OptionParser.new do |opts|
    opts.on('-l', 'has_line_count') do
      options[:has_line_count] = true
    end

    opts.on('-w', 'has_word_count') do
      options[:has_word_count] = true
    end

    opts.on('-c', 'has_char_count') do
      options[:has_char_count] = true
    end
  end.parse!

  if options.values.none?
    options = options.transform_values! { true }
  end

  options
end

def count_char(file_path)
  char_count = 0

  File.open(file_path, "r") do |file|
    file.each_char do |char|
      char_count += 1
    end
  end
  char_count
end

def count_word(file_path)
  word_count = 0

  File.open(file_path, "r") do |file|
    file.each_line do |line|
      words = line.split(/\s+/)
      word_count += words.size
    end
  end
  word_count
end

def count_line(file_path)
  line_count = 0

  File.open(file_path, "r") do |file|
    file.each_line do |line|
      line_count += 1
    end
  end
  line_count
end

def calculate_length(files)
  sum = { char: 0, word: 0, line: 0 }
  files.each do |file|
    sum[:char] += count_char(file)
    sum[:word] += count_word(file)
    sum[:line] += count_line(file)
  end
  char_length = sum[:char].to_s.length
  word_length = sum[:word].to_s.length
  line_length = sum[:line].to_s.length

  return sum, char_length, word_length, line_length
end

def total_display(options, sum, char_length, word_length, line_length)
  total_set = ["合計"]

  if options[:has_char_count]
    total_set.unshift(format("%#{char_length}s",sum[:char].to_s))
  end

  if options[:has_word_count]
    total_set.unshift(format("%#{word_length}s",sum[:word].to_s))
  end

  if options[:has_line_count]
    total_set.unshift(format("%#{line_length}s",sum[:line].to_s))
  end
  total_set_str = total_set.join(' ')
  puts total_set_str
end

def input_argument(files)
  options = determine_options
  sum, char_length, word_length, line_length = calculate_length(files)

  files.each do |file|
    file_set = []
    file_set.unshift(file)
    if options[:has_char_count]
      file_set.unshift(format("%#{char_length}s",count_char(file)))
    end

    if options[:has_word_count]
      file_set.unshift(format("%#{word_length}s",count_word(file)))
    end

    if options[:has_line_count]
      file_set.unshift(format("%#{line_length}s",count_line(file)))
    end
    file_set_str = file_set.join(' ')
    puts file_set_str
  end

  if files.size >= 2
    total_display(options, sum, char_length, word_length, line_length)
  end
end

def input_pipe
  file = $stdin.read
  options = determine_options

  file_set = [] 
  if options[:has_char_count]
    char_count = 0
    file.each_char do |char|
      char_count += 1
    end
    file_set.unshift(char_count)
  end

  if options[:has_word_count]
    word_count = 0
    file.each_line do |line|
      words = line.split(/\s+/)
      word_count += words.size
    end
    file_set.unshift(word_count)
  end

  if options[:has_line_count]
    line_count = 0
    file.each_line do |line|
      line_count += 1
    end
    file_set.unshift(line_count)
  end

  file_set_str = file_set.join(' ')
  puts file_set_str
end

def excuse_wc
  if ARGV.empty?
    input_pipe
  else
    input_argument(ARGV)
  end
end

excuse_wc
