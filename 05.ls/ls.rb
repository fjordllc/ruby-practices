#!/usr/bin/env ruby

children = Dir.glob('*').sort

# 文字数の最大値を算出。
string_length_max = children.map { |items| items.length }.max

MAX_COLUMN = 3

output_row_num = children.size % 3 > 0 ? children.size / 3 + 1 : children.size / 3

results = []
children.each_slice(output_row_num) do |items|
  results << items.map { |item| item }
end

tmp_arry = []
i = 0
output_row_num.times do
  results.each do |item|
    tmp_arry << item[i]
  end
  i += 1
end

sorted_results = []
sorted_results.each_slice(MAX_COLUMN) do |items|
  sorted_results << items.map { |item| item }
end

sorted_results.each do |items|
  puts items.map { |item| "% -#{string_length_max}s " % item }.join
end
