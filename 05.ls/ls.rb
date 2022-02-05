#!/usr/bin/env ruby
# frozen_string_literal: true

names_original = Dir.glob('*') # コマンドを実行したディレクトリのファイル名の配列
letter_max = names_original.map(&:size).max # 文字数が最大の要素の文字数
tab_space = letter_max / 8 + 1 # 各文字列を表示するスペースのタブ数

# ファイル名をタブ揃えにして配列に再代入
names_tabbed =
  names_original.map do |w|
    w + "\t" * (tab_space - w.size / 8)
  end

lines = names_tabbed.size / 3 + 1 # 配列の要素数(ファイル数)から表示行数を算出
names_horizontal = names_tabbed.each_slice(lines).to_a # 配列を3分割(各列に対応)
names_vertical = names_horizontal.first(2).transpose.to_a # 配列の0番目、1番目の配列の縦横を入替え、各行2列目までの配列を取得

# 各行に2番目の要素を順番に追加
names_horizontal[2].length.times do |n|
  names_vertical[n] << names_horizontal[2][n]
end

names_vertical.each { |w| puts w.join } # 出力
