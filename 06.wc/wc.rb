#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  params = ARGV.getopts('l')
  collected_string = collect_string
  string_data = collect_string_data(collected_string)
  total_files_data = sum_file_data(string_data)
  output_string_data(params, string_data, total_files_data)
end

def collect_string
  if ARGV.empty?
    collected_string = []
    collected_string << { string: $stdin.read }
  else
    collected_string = ARGV.map do |file|
      {
        string: File.read(file),
        filename: File.basename(file)
      }
    end
  end
  collected_string
end

def collect_string_data(collected_string)
  collected_string.map do |string|
    {
      lines: string[:string].count("\n"),
      words: string[:string].lstrip.split(/\s+/).size,
      bytes: string[:string].bytesize,
      filename: string[:filename]
    }
  end
end

def sum_file_data(string_data)
  {
    total_of_lines: string_data.sum { |lines| lines[:lines] },
    total_of_words: string_data.sum { |words| words[:words] },
    total_of_bytes: string_data.sum { |bytes| bytes[:bytes] }
  }
end

def output_string_data(params, string_data, total_files_data)
  string_data.each do |string|
    print string[:lines].to_s.rjust(8)
    print ' '
    print "#{string[:words].to_s.rjust(7)}#{string[:bytes].to_s.rjust(8)} " unless params['l']
    puts string[:filename]
  end

  return unless string_data.size > 1

  print total_files_data[:total_of_lines].to_s.rjust(8)
  print "#{total_files_data[:total_of_words].to_s.rjust(8)}#{total_files_data[:total_of_bytes].to_s.rjust(8)}" unless params['l']
  puts ' total'
end

main
