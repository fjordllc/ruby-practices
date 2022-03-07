#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  params = ARGV.getopts('l')
  collected_string = collect_string
  string_data = collect_string_data(collected_string)
  total_files_data = sum_file_data(string_data)
  show_file_data(params, string_data, total_files_data)
end

#文字列を渡して、lines, words, bytesを返してくれるメソッドがあると、
#このファイルの中に複数存在するカウント処理を1箇所にまとめられそうですね。検討をお願いいたします
#ファイルを繰り返すメソッドを作る？

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

def show_file_data(params, string_data, total_files_data)
  params['l'] ? output_lines(string_data, total_files_data) : output_file_data(string_data, total_files_data)
end

def output_lines(string_data, total_files_data)
  string_data.each do |file_data|
    puts "#{file_data[:lines].to_s.rjust(8)} #{file_data[:filename]}"
  end
  puts "#{total_files_data[:total_of_lines].to_s.rjust(8)} total" if string_data.size > 1
end

def output_file_data(string_data, total_files_data)
  string_data.each do |file_data|
    puts "#{file_data[:lines].to_s.rjust(8)} #{file_data[:words].to_s.rjust(7)} #{file_data[:bytes].to_s.rjust(7)} " \
    "#{file_data[:filename]}"
  end
  return unless string_data.size > 1

  puts "#{total_files_data[:total_of_lines].to_s.rjust(8)} #{total_files_data[:total_of_words].to_s.rjust(7)} " \
  "#{total_files_data[:total_of_bytes].to_s.rjust(7)} total"
end

main
