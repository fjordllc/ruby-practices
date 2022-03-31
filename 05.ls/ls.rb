#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  params = ARGV.getopts('a')
  current_dir_items =
    if params['a']
      Dir.glob('*', File::FNM_DOTMATCH)
    else
      Dir.glob('*')
    end
  format(current_dir_items)
end

def format(current_dir_items)
  columun_count = 3
  current_dir_items << ' ' until (current_dir_items.size % columun_count).zero?

  # 1列に格納するファイル数
  row = (current_dir_items.size / columun_count).ceil

  # current_dir_itemsの中で、最も大きいファイルサイズ＋固定で追加するスペース数を格納
  fixed_space_size = 7
  max_space_size = current_dir_items.max_by(&:length).length + fixed_space_size

  # 左揃えにするため、各要素に空白を追加
  space_added_items =
    current_dir_items.map do |items|
      each_space_size = max_space_size - items.size
      items + ' ' * each_space_size
    end

  transposed_items = space_added_items.each_slice(row).to_a.transpose

  display(transposed_items)
end

# 出力
def display(transposed_items)
  transposed_items.each do |items|
    puts items.join('')
  end
end

main
