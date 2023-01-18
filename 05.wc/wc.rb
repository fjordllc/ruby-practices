# frozen_string_literal: true

require 'optparse'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.on('-w') { |v| params[:w] = v }
  opt.on('-c') { |v| params[:c] = v }
  opt.parse!(ARGV)
  options = %i[l w c]
  options.map! { |o| o if params[o] }.compact! unless params.empty?
  if ARGV.empty?
    input_files = []
    input_files.push($stdin.read)
    input_files_output(input_files, options)
  else
    files = ARGV
    files_output(files, options)
  end
end

def input_files_output(input_files, options)
  p_s = options.size - 1
  input_files_data(input_files, options).each do |input_file_data|
    (0..p_s).each { |n| print input_file_data[n].to_s.rjust(8) }
    puts
  end
end

def input_files_data(input_files, options)
  input_items = options.map { |key| count_items(input_files, input_files, key) }
  input_items.transpose
end

def files_output(files, options)
  files_name = files.map { |file| File.basename(file) }
  files_name.push('total') unless files.size == 1
  files_result = [files_name, files_data(files, options)].transpose.to_h
  p_s = options.size - 1
  files_result.each do |file_name, file_data|
    (0..p_s).each { |n| print file_data[n].to_s.rjust(8) }
    print " #{file_name}"
    puts
  end
end

def files_data(files, options)
  items = options.map { |key| files_items(files, key) }
  data = items.transpose
  unless files.size == 1
    total_item = items.map(&:sum)
    data.push(total_item)
  end
  data
end

def files_items(files, key)
  files_open = files.map { |file| File.open(file) }
  files_read = files_open.map(&:read)
  count_items(files_open, files_read, key)
end

def count_items(files_open, files_read, key)
  case key
  when :l
    count_lines(files_read)
  when :w
    count_words(files_read)
  when :c
    count_size(files_open)
  end
end

def count_lines(files)
  files.map { |file| file.count("\n") }
end

def count_words(files)
  files.map do |file|
    array = file.split(/\s+/)
    array.size
  end
end

def count_size(files)
  files.map(&:size)
end

main
