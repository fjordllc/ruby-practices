#!/bin/sh
exec ruby -x "$0" "$@"
#!ruby

# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
options = {}
opt.on('-l') { |v| v }
opt.parse!(ARGV, into: options)

display = []

l_num_total = 0
w_num_total = 0
c_num_total = 0
count = 0

ARGV.each do |arg|
  l_num = w_num = c_num = 0
  File.open(arg) do |f|
    while (line = f.gets)
      line.chomp!
      l_num += 1
      words = line.split(/\s+/).reject(&:empty?)
      w_num += words.size

    end
    c_num += f.size
    display << { l_num: l_num, w_num: w_num, c_num: c_num, file_name: arg }
  end
  l_num_total += l_num
  w_num_total += w_num
  c_num_total += c_num
  count += 1
end

display << { l_num: l_num_total, w_num: w_num_total, c_num: c_num_total, file_name: 'total' } unless count == 1 || count.zero?

display.each do |part|
  if options[:l]
    printf("%<l_num>d %<file_name>s\n", l_num: part[:l_num], file_name: part[:file_name])
  else

    printf("%<l_num>d %<w_num>d %<c_num>d %<file_name>s\n", l_num: part[:l_num], w_num: part[:w_num], c_num: part[:c_num], file_name: part[:file_name])

  end
end
if ARGV.empty?

  l_num = w_num = c_num = 0

  while (line = $stdin.gets)
    l_num += 1
    c_num += line.bytesize
    line.chomp!
    words = line.split(/\s+/).reject(&:empty?)
    w_num += words.size

  end
  if options[:l]
    printf("%<l_num>d\n", l_num: l_num)
  else
    printf("%<l_num>d %<w_num>d %<c_num>d\n", l_num: l_num, w_num: w_num, c_num: c_num)
  end
end
