#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  params = ARGV.getopts('l')
  files_data = collect_file_data
  total_files_data = sum_file_data(files_data)
  determine_display_target(params, files_data, total_files_data)
end

def collect_file_data
  files_data = []
  ARGV.each do |file|
    read_data = File.read(file)
    file_data = {
      lines: read_data.count("\n"),
      words: read_data.split(/\s+/).size,
      bites: read_data.bytesize,
      filename: File.basename(file)
    }
    files_data << file_data
  end
  files_data
end

def sum_file_data(files_data)
  {
    total_of_lines: files_data.sum { |lines| lines[:lines] },
    total_of_words: files_data.sum { |words| words[:words] },
    total_of_bites: files_data.sum { |bites| bites[:bites] }
  }
end

def determine_display_target(params, files_data, total_files_data)
  files_data.empty? ? show_stdin_data(params) : show_file_data(params, files_data, total_files_data)
end

def show_stdin_data(params)
  standard_inputs = $stdin.read
  if params['l']
    puts "#{standard_inputs.count("\n").to_s.rjust(8)} "
  else
    puts "#{standard_inputs.count("\n").to_s.rjust(8)} #{standard_inputs.split(/\s+/).size.to_s.rjust(7)} #{standard_inputs.bytesize.to_s.rjust(7)}"
  end
end

def show_file_data(params, files_data, total_files_data)
  params['l'] ? output_lines(files_data, total_files_data) : output_file_data(files_data, total_files_data)
end

def output_lines(files_data, total_files_data)
  files_data.each do |file_data|
    puts "#{file_data[:lines].to_s.rjust(8)} #{file_data[:filename]}"
  end
  puts "#{total_files_data[:total_of_lines].to_s.rjust(8)} total" if files_data.size > 1
end

def output_file_data(files_data, total_files_data)
  files_data.each do |file_data|
    puts "#{file_data[:lines].to_s.rjust(8)} #{file_data[:words].to_s.rjust(7)} #{file_data[:bites].to_s.rjust(7)} " \
    "#{file_data[:filename]}"
  end
  return unless files_data.size > 1

  puts "#{total_files_data[:total_of_lines].to_s.rjust(8)} #{total_files_data[:total_of_words].to_s.rjust(7)} " \
  "#{total_files_data[:total_of_bites].to_s.rjust(7)} total"
end

main
