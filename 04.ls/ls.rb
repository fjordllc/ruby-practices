#!/usr/bin/env ruby

# 半角スペースでリスト内の要素を左詰めする
def adjust_with_margin(list)
  adjusted_list = []
  list.each do |elem|
    max_chars = list.map(&:size).max
    adjusted_list.push(elem.ljust(max_chars))
  end
  adjusted_list
end

# カレントディレクトリ内にあるディレクトリ、ファイルの名前を取得
files_and_dirs_name = []
Dir.foreach('./') do |name|
  ## 「.」「..」隠しファイルを除外
  files_and_dirs_name.push(name) unless '.'.eql?(name[0])
end

# アルファベット順にソート
files_and_dirs_name = files_and_dirs_name.sort

# ターミナルの幅に関わらず横に最大３列を維持するため
# ３つの配列に要素を詰める
tmp_list = []
files_and_dirs_name.each_slice(files_and_dirs_name.size / 3 + 1) { |list| tmp_list.push(adjust_with_margin(list)) }

# 各配列の要素数を揃えるために、要素数が足りないリストにnilを入れる
max_elem = tmp_list.max_by(&:size).size
output_list = tmp_list.each do |elem|
  elem << nil while elem.size < max_elem
end

puts(output_list.transpose.map { |row| row.join(' ') })
