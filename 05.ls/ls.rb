#!/usr/bin/env ruby
# frozen_string_literal: true

def ls
  files = Dir.glob('*').sort

  total_file = files.size

  max_row = 3.0
  columns = (total_file / max_row).ceil

  ary = []
  files.each_slice(columns) do |list_of_file|
    ary << list_of_file

    # 最大要素数を取得して、その要素数に合わせる
    max_size = ary.map(&:size).max
    ary.map! { |it| it.values_at(0...max_size) }
  end

  # rowとcolumnの入れ替え
  sort_of_lists = ary.transpose

  sort_of_lists.each do |sort_of_file|
    sort_of_file.each do |s|
      print s.to_s.ljust(15)
    end
    print "\n"
  end
end
ls
