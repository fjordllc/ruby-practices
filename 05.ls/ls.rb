#!/usr/bin/env ruby
# frozen_string_literal: true

# 引数に入力したディレクトリの内容一覧を配列として取得
def load_dir(dir)
  list = []
  Dir.each_child(dir) do |f|
    list << f
  end
  list
end

# 引数に入力した列数でディレクトリの内容一覧を表示
def sort_list(max_column)
  max_low = load_dir('test').size / max_column + 1 # 表示する行数の最大を計算

  splited_list = load_dir('test').sort.each_slice(max_low).to_a # 行と列を入れ替えるために多次元配列に分割

  sorted_list = splited_list.map do |a| # transposeメソッドを使うために各配列の要素数を揃える
    a.values_at(0..max_low - 1)
  end

  sorted_list.transpose.each do |files| # 行と列を入れ替え
    print "#{files.join('      ')}\n"
  end
end

load_dir('test')
sort_list(3)
