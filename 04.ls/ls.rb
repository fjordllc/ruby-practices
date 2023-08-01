# frozen_string_literal: true

def file_entries
  Dir.glob('*')
end

def align_left(string, entries)
  max_length = entries.flatten.map { |entry| entry.to_s.size + 5 }.max
  string.to_s.ljust(max_length) # 引数1を左揃え（取得した名称の最大文字数に+5した数値で揃える）
end

entries = file_entries.each_slice((file_entries.size.to_f / 3).ceil).to_a 
entries_max_size = entries.map(&:size).max 

new_entries = entries.map do |entry| # 二次元配列の要素数が均等じゃなかった場合、均等になるようにnilを追加
  entry.concat([nil] * (entries_max_size - entry.size)) if entries_max_size > entry.size
  entry
end

new_entries.transpose.each do |entry|
  puts entry.map { |item| align_left(item, entries) }.join
end
