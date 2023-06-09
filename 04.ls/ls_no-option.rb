# frozen_string_literal: true

def file_entries # 隠し以外のファイルとディレクトリを取得しソート
  Dir.glob("*").sort
end

def align_left(string) # 要素を左揃え
  string.to_s.ljust(30)
end

entries = file_entries.each_slice((file_entries.size.to_f / 3).ceil).to_a #.compact # 列数（３）と同じ数に分割、2次元配列にする
entries_max_size = entries.map { |i| i.size }.max # 二次元配列の中にある配列の最大要素数を取得

new_entries = entries.map do |entry| # 二次元配列の要素数が均等じゃなかった場合、均等になるようにnilを追加
  entry << nil if entries_max_size > entry.size
  entry 
end

new_entries.transpose.each do |entry| # 配列を列を行に変換することで、各配列の先頭から値を並行して取り出す
  puts entry.map { |item | align_left(item) }.join
end

