#!/usr/bin/env ruby

# TODO: オプション処理時追加 require 'optparse'

# TODO: オプション処理時追加 opt = OptionParser.new
ls_target_path = ARGV[-1].nil? ? '.' : ARGV[-1]
dir_item_list = []
sorted_dir_item_list = []
output_item_width = 1

HORIZONTAL_ITEMS_COUNT = 3
ITEMS_INTERVAL = 5

begin
  if FileTest.directory?(ls_target_path)
    # TODO: -l オプション時に詳細を取得する処理を書く
    Dir.foreach(ls_target_path) do |item_in_dir|
      # TODO: -aオプションによる切り替えを行う
      next unless /^\..*/.match(item_in_dir).nil?

      dir_item_list << item_in_dir
      output_item_width = item_in_dir.size + ITEMS_INTERVAL > output_item_width ? item_in_dir.size + ITEMS_INTERVAL : output_item_width
      # print dir_item_list
    end
    # TODO: -rオプションの際にASC処理ではなくDESC処理をする
    dir_item_list = dir_item_list.sort
    max_vertical_items_count = (dir_item_list.size.to_f / HORIZONTAL_ITEMS_COUNT).ceil
    max_vertical_items_count.times do |count|
      dir_item_list.each_with_index do |v, i|
        next if i % max_vertical_items_count != count

        sorted_dir_item_list << v
      end
    end
    sorted_dir_item_list.each_slice(HORIZONTAL_ITEMS_COUNT) do |line_items|
      line_items.each do |line_item|
        print format("%-#{output_item_width}.*s", output_item_width, line_item)
      end
      puts
    end

  elsif FileTest.file?(ls_target_path)
    # TODO: -l オプション時に詳細を取得する処理を書く
    print ls_target_path
    puts
  else
    raise StandardError, "ls: #{ls_target_path}: No such file or directory"
  end
rescue StandardError => e
  print e.message
  puts
end

