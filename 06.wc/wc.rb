#!/usr/bin/env ruby

def main
  files_data = collect_file_data
  show_file_data(files_data)
  total_files_data = sum_file_data(files_data)
  show_total_files_data(total_files_data)
end

def collect_file_data
files_data = []
ARGV.each do |file|
  read_data = File.read(file)
  file_data = {
    lines: read_data.count("\n"),
    words: read_data.split(/\s+|[[:blank:]]+/).size,
    bites: read_data.bytesize,
    filename: File.basename(file)
  }
  files_data << file_data
end
files_data
end

def sum_file_data(files_data)
  total_files_data = {
  total_of_lines: files_data.sum { |lines| lines[:lines] },
  total_of_words: files_data.sum { |words| words[:words] },
  total_of_bites: files_data.sum { |bites| bites[:bites] },
  } 
end

def show_file_data(files_data)
  files_data.each do |file_data|
    puts "#{file_data[:lines].to_s.rjust(8)} #{file_data[:words].to_s.rjust(7)} #{file_data[:bites].to_s.rjust(7)} #{file_data[:filename]}"
  end
end

def show_total_files_data(total_files_data)
  puts "#{total_files_data[:total_of_lines].to_s.rjust(8)} #{total_files_data[:total_of_words].to_s.rjust(7)} #{total_files_data[:total_of_bites].to_s.rjust(7)} total"
end

main


