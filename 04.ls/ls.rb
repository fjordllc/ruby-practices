#!/usr/bin/env ruby

require 'optparse'

def adjust_with_margin(list)
  max_chars = list.map(&:size).max
  list.map { |item| item.ljust(max_chars) }
end

# ターミナルの幅に関わらず横に最大３列を維持するため
# ３つの配列に要素を詰める
def push_elem_to_three_lists(files_and_dirs_name)
  tmp_list = []
  files_and_dirs_name.each_slice(files_and_dirs_name.size / 3 + 1) do |list|
    tmp_list << adjust_with_margin(list)
  end
  tmp_list
end

formatted_list = []

opt = OptionParser.new
opt.on('-a') do
  files_and_dirs_name = Dir.entries('.')
  formatted_list = push_elem_to_three_lists(files_and_dirs_name.sort)
end
opt.parse!(ARGV)

if formatted_list.empty?
  files_and_dirs_name = Dir.glob('*')
  formatted_list = push_elem_to_three_lists(files_and_dirs_name)
end

# 各配列の要素数を揃えるために、要素数が足りないリストにnilを入れる
max_elem = formatted_list.max_by(&:size).size
output_list = formatted_list.each do |elem|
  elem << nil while elem.size < max_elem
end

puts(output_list.transpose.map { |row| row.join(' ') })

