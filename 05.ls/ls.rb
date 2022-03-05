#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  # ファイル取得
  files = Dir.glob('*').sort

  # 後にtransposeを使用するため、filesの中身の数が3で割り切れる数になるまで空白を配列に追加する
  files << ' ' until (files.size % 3).zero?

  # 左揃えにするため、20を上限としてfilesの各要素に空白を追加した配列を作成
  space_added_files = files.map do |file|
    file.ljust(20, ' ')
  end
  split_files(space_added_files, files)
end

# 取得したファイルを分割して3つの配列に格納
def split_files(space_added_files, files)
  columun_count = 3

  array1 = []
  array2 = []
  array3 = []

  divide = (files.size / columun_count).ceil
  space_added_files.each do |file|
    if array1.size < divide
      array1 << file
    elsif array2.size < divide
      array2 << file
    else
      array3 << file
    end
  end

  # transposeで行列を逆にする
  transposed_array = [
    array1,
    array2,
    array3
  ].transpose

  display(transposed_array)
end

# 出力
def display(transposed_array)
  transposed_array.each do |file|
    puts file.join('')
  end
end

main
