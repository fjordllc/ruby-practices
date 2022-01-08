#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def list_of_elements
  options = ARGV.getopts('alr')
  elements = if options['a']
               Dir.glob('*', File::FNM_DOTMATCH).sort
             else
               Dir.glob('*').sort
             end

  total_element = elements.size

  maximum_width = 3.0
  columns = (total_element / maximum_width).ceil

  lists = []
  elements.each_slice(columns) do |list|
    lists << list

    # 最大要素数を取得して、その要素数に合わせる
    max_size = lists.map(&:size).max
    lists.map! { |it| it.values_at(0...max_size) }
  end
  lists
end

def main
  # rowとcolumnの入れ替え
  sort_of_lists = list_of_elements.transpose

  # 配列の最大文字数を取得し、その文字数+余白分で等間隔表示する
  max_word_count = sort_of_lists.flatten.max_by { |x| x.to_s.length }
  spacing_between_elements = max_word_count.length + 15

  sort_of_lists.each do |sort_of_list|
    sort_of_list.each do |s|
      print s.to_s.ljust(spacing_between_elements)
    end
    print "\n"
  end
end
main
