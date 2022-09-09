#!/usr/bin/env ruby

# TODO: オプション処理時追加 require 'optparse'

# TODO: オプション処理時追加 opt = OptionParser.new
ls_target_path = ARGV[-1].nil? ? '.' : ARGV[-1]
dir_items_list = []
output_item_width = 10

HORIZONTAL_ITEMS_COUNT = 3
ITEMS_INTERVAL = 5

def ls_sort(target_list, horizontal_num, sort_reverse: false)
  # TODO: -rオプションの際にASC処理ではなくDESC処理をする
  max_vertical_items_count = (target_list.size.to_f / horizontal_num).ceil
  target_list = sort_reverse == true ? target_list.sort.reverse : target_list.sort
  sorted_list = []
  max_vertical_items_count.times do |count|
    target_list.each_with_index do |v, i|
      next if i % max_vertical_items_count != count

      sorted_list << v
    end
  end
  sorted_list
end

def ls_print(target, item_width, horizontal_num)
  # TODO: -l オプション時に詳細を取得する処理を書く
  if target.is_a?(Array)
    target.each_slice(horizontal_num) do |line_items|
      line_items.each do |line_item|
        print format("%-#{item_width}.*s", item_width, line_item)
      end
      puts
    end
  else
    print target
    puts
  end
end

begin
  if FileTest.directory?(ls_target_path)
    Dir.foreach(ls_target_path) do |item_in_dir|
      # TODO: -aオプションによる切り替えを行う
      next unless /^\..*/.match(item_in_dir).nil?

      dir_items_list << item_in_dir
      output_item_width = item_in_dir.size + ITEMS_INTERVAL > output_item_width ? item_in_dir.size + ITEMS_INTERVAL : output_item_width
    end
    sorted_dir_items_list = ls_sort(dir_items_list, HORIZONTAL_ITEMS_COUNT)

    ls_print(sorted_dir_items_list, output_item_width, HORIZONTAL_ITEMS_COUNT)

  elsif FileTest.file?(ls_target_path)
    ls_print(ls_target_path, output_item_width, 1)
  else
    raise StandardError, "ls: #{ls_target_path}: No such file or directory"
  end
rescue StandardError => e
  print e.message
  puts
end
