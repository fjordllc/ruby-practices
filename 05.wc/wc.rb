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
  files = ARGV.empty? ? [$stdin.read] : ARGV
  files_output(files, options)
end

def files_output(files, options)
  files_result = [files_name(files), files_data(files, options)].transpose.to_h
  files_result.each do |file_name, file_data|
    options.each_with_index { |_, n| print file_data[n].to_s.rjust(8) }
    print " #{file_name}"
    puts
  end
end

def files_name(files)
  files_name = ARGV.empty? ? [' '] : files.map { |file| File.basename(file) }
  files_name.push('total') unless files.size == 1
  files_name
end

def files_data(files, options)
  fs = ARGV.empty? ? files : files_read(files)
  items = options.map { |key| count_items(fs, key) }
  data = items.transpose
  unless files.size == 1
    total_item = items.map(&:sum)
    data.push(total_item)
  end
  data
end

def files_read(files)
  files.map do |file|
    File.open(file, &:read)
  end
end

def count_items(files, key)
  case key
  when :l
    count_lines(files)
  when :w
    count_words(files)
  when :c
    count_size(files)
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
