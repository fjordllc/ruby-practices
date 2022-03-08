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

#ファイル名をwcの出力結果にくっつける

def collect_string
  collected_string = []
  ARGV.empty? ? collected_string << $stdin.read : ARGV.map { |file| collected_string << File.read(file) }
  collected_string
end

def collect_filename
  files_name = []
  ARGV.map do |file|
    file_name = {filename: File.basename(file)}
    files_name << file_name
  end
  files_name
end

def collect_string_data(collected_string)
  strings_data = []
  collected_string.map do |string|
    string_data = {
      lines: string.count("\n"),
      words: string.split(/\s+/).size,
      bytes: string.bytesize
    }
    strings_data << string_data
  end
  strings_data
end

def sum_file_data(string_data)
  {
    total_of_lines: string_data.sum { |lines| lines[:lines] },
    total_of_words: string_data.sum { |words| words[:words] },
    total_of_bytes: string_data.sum { |bytes| bytes[:bytes] }
  }
end

#ここも lines words bytes filename option を渡すと決められたフォーマットで出力するメソッドを定義しておくと、
#出力フォーマットを1箇所にまとめられそうですね。

def output_string_data(params, string_data, total_files_data)
  string_data.each do |string|
    print "#{string[:lines].to_s.rjust(8)}"
    print "#{string[:words].to_s.rjust(8)} #{string[:bytes].to_s.rjust(7)} " unless params['l']
    puts "\n"
  end

  if string_data.size > 1
    print "#{total_files_data[:total_of_lines].to_s.rjust(8)}" 
    print "#{total_files_data[:total_of_words].to_s.rjust(8)} #{total_files_data[:total_of_bytes].to_s.rjust(7)}" unless params['l']
    puts " total"
  end
end

main
