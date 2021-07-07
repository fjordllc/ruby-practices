#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# 入力
opt = OptionParser.new

options = {}

opt.on('-l') { |v| options[:l] = v }
opt.parse!(ARGV)
files = ARGV

# 出力内容を作成
output = []

if files.empty? # 引数にファイルがない場合
  stdin = $stdin.readlines.join
  output << [stdin.count("\n"), stdin.split.length, stdin.bytesize]
else
  file_strings = files.map { |file_name| File.open(file_name).read } # ファイルを閉じた方が良いかも？
  files.zip(file_strings).each do |file_name, file_string|
    output << if options[:l]
                [file_string.count("\n"), file_name]
              else
                [file_string.count("\n"), file_string.split.length, file_string.bytesize, file_name]
              end
  end

  if files.size > 1 # 引数のファイルが複数個の場合
    output << if options[:l]
                [
                  file_strings.map { |file_string| file_string.count("\n") }.sum,
                  'total'
                ]
              else
                [
                  file_strings.map { |file_string| file_string.count("\n") }.sum,
                  file_strings.map { |file_string| file_string.split.length }.sum,
                  file_strings.map(&:bytesize).sum,
                  'total'
                ]
              end
  end
end

# 出力
puts(output.map { |line| line[0..-2].map { |s| s.to_s.rjust(7) }.append(line[-1]).join(' ') })
