#!/usr/bin/env ruby
# frozen_string_literal: true

names_original = Dir.glob('*') # コマンドを実行したディレクトリのファイル名の配列

# メインのメソッド
def print_ls(names_original)
  names_tabbed = tabbing_names(names_original)
  names_vertical = [] # 空配列の中に行数分の空配列を追加（入れ子構造）
  lines(names_tabbed).times do
    names_vertical << []
  end
  names_tabbed.each_with_index do |file, i| # 空配列に順番に値を追加、を繰り返す。
    names_vertical[i % lines(names_tabbed)] << file.to_s
  end

  names_vertical.each { |w| puts w.join }
end

# 取得したファイル名にタブを追加して長さを揃える
def tabbing_names(names_original)
  tab_space = names_original.map(&:size).max / 8 + 1
  names_original.map do |w|
    w + "\t" * (tab_space - w.size / 8)
  end
end

# 取得した配列の要素数から表示行数を算出
def lines(names_tabbed)
  (names_tabbed.size - 1) / 3 + 1
end

print_ls(names_original)
