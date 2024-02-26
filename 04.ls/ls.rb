#!/usr/bin/env ruby

def adjust_with_margin(list)
  max_chars = list.map(&:size).max
  list.map { |item| item.ljust(max_chars) }
end

# ターミナルの幅に関わらず横に最大３列を維持するため
# ３つの配列に要素を詰める
tmp_list = []
files_and_dirs_name = Dir.glob('*')
files_and_dirs_name.each_slice(files_and_dirs_name.size / 3 + 1) do |list|
  tmp_list << adjust_with_margin(list)
end

# 各配列の要素数を揃えるために、要素数が足りないリストにnilを入れる
max_elem = tmp_list.max_by(&:size).size
output_list = tmp_list.each do |elem|
  elem << nil while elem.size < max_elem
end

puts(output_list.transpose.map { |row| row.join(' ') })
