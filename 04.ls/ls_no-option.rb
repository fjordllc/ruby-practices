def get_entries # 隠し以外のファイルとディレクトリを取得
  Dir.entries('.').reject{ |entry| entry.start_with?('.') }
end

def align_left(string)
  string.ljust(30)
end

entries = get_entries().each_slice((get_entries().size.to_f / 3).ceil).to_a #　配列を列数（3）と同じ数に分割
entries_max_size = entries.map(&:size).max # 2次元配列の中で最も要素が多い配列の要素数

(0..entries_max_size - 1).each do |i|
  puts "#{align_left(entries[0][i])} #{align_left(entries[1][i])} #{align_left(entries[2][i])}" # 列数が4以上にする場合は #{entries[3][i]}.. を追加しないといけない リファクタリングだが難しくて断念 
end

