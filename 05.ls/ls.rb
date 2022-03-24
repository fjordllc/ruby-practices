#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  # ファイル取得
  files = Dir.glob('*')

  columun_count = 3
  files << ' ' until (files.size % columun_count).zero?

  # 1列に格納するファイル数
  row = (files.size / columun_count).ceil

  # filesの中で、最も大きいファイルサイズ＋固定で追加するスペース数を格納
  fixed_space_size = 7
  max_space_size = files.max_by(&:length).length + fixed_space_size

  # 左揃えにするため、各要素に空白を追加
  space_added_files = files.map do |f|
    each_space_size = max_space_size - f.size
    f + ' ' * each_space_size
  end

  transposed_arrays = space_added_files.each_slice(row).to_a.transpose
  display(transposed_arrays)
end

# 出力
def display(transposed_arrays)
  transposed_arrays.each do |file|
    puts file.join('')
  end
end

main
