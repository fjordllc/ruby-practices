# frozen_string_literal: true

def file_entries # 隠し以外のファイルとディレクトリを取得しソート
  Dir.glob("*").sort
end

def align_left(string, entries) # 要素を左揃え
  max_length = entries.flatten.map { |entry| entry.to_s.size + 5 }.max
  string.to_s.ljust(max_length) # 引数1を左揃え（取得した名称の最大文字数に+5した数値で揃える）
end

entries = file_entries.each_slice((file_entries.size.to_f / 3).ceil).to_a # 列数（３）と同じ数に分割、二次元配列にする
entries_max_size = entries.map { |i| i.size }.max # 二次元配列の中にある配列の最大要素数を取得

new_entries = entries.map do |entry| # 二次元配列の要素数が均等じゃなかった場合、均等になるようにnilを追加
  entry.concat([nil] * (entries_max_size - entry.size)) if entries_max_size > entry.size 
  entry 
end

new_entries.transpose.each do |entry| # 配列を列を行に変換することで、各配列の先頭から値を並行して取り出す
  puts entry.map { |item | align_left(item,entries) }.join
end

