#!/usr/bin/env ruby
# frozen_string_literal: true

def ls
  files = Dir.glob('*').sort

  total_file = files.size

  maximum_width = 3.0
  columns = (total_file / maximum_width).ceil

  lists = []
  files.each_slice(columns) do |list_of_file|
    lists << list_of_file

    # 最大要素数を取得して、その要素数に合わせる
    max_size = lists.map(&:size).max
    lists.map! { |it| it.values_at(0...max_size) }
  end

  # rowとcolumnの入れ替え
  sort_of_lists = lists.transpose

  # 配列の最大文字数を取得し、その文字数+余白分で等間隔表示する
  max_word_count = sort_of_lists.flatten.max_by { |x| x.to_s.length }
  spacing_between_elements = max_word_count.to_s.length + 15

  sort_of_lists.each do |sort_of_file|
    sort_of_file.each do |s|
      print s.to_s.ljust(spacing_between_elements)
    end
    print "\n"
  end
end
ls
