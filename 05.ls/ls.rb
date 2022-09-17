#!/usr/bin/env ruby

# TODO: オプション処理時追加 require 'optparse'

# TODO: オプション処理時追加 opt = OptionParser.new
ls_target_path = ARGV[-1].nil? ? '.' : ARGV[-1]
dir_items_list = []
horizontal_items_count = 3
output_item_width = 10

ITEMS_INTERVAL = 5

def ls_sort(target_list, horizontal_num, sort_reverse: false)
  # 行方向に昇順（-r では降順）表示にするために行方向の最大行数を取得
  max_vertical_items_count = (target_list.size.to_f / horizontal_num).ceil
  target_list = sort_reverse == true ? target_list.sort.reverse : target_list.sort
  sorted_list = []
  # 一行ごとの隣り合うアイテムが最大行数ごとに並ぶように昇順（-r では降順）済みリストインデックスを並び替える
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
  target.each_slice(horizontal_num) do |line_items|
    line_items.each do |line_item|
      print format("%-#{item_width}.*s", item_width, line_item)
    end
    puts
  end
end

begin
  if FileTest.directory?(ls_target_path)
    Dir.foreach(ls_target_path) do |item_in_dir|
      # TODO: -aオプションによる切り替えを行う
      next unless /^\..*/.match(item_in_dir).nil?

      dir_items_list << item_in_dir
      # NOTE: 表示アイテムの最大文字列とアイテム間のスペースがoutput_item_widthを超えていたらoutput_item_widthを更新する
      # NOTE: （補足）output_item_widthとは一つのアイテムが横幅でとってよい幅のこと
      output_item_width = item_in_dir.size + ITEMS_INTERVAL > output_item_width ? item_in_dir.size + ITEMS_INTERVAL : output_item_width
    end
    sorted_dir_items_list = ls_sort(dir_items_list, horizontal_items_count)
    # TODO: -rオプションの際にASC処理ではなくDESC処理をする
    ls_print(sorted_dir_items_list, output_item_width, horizontal_items_count)

  elsif FileTest.file?(ls_target_path)
    dir_items_list << ls_target_path
    ls_print(dir_items_list, output_item_width, 1)
  else
    raise StandardError, "ls: #{ls_target_path}: No such file or directory"
  end
rescue StandardError => e
  print e.message
  puts
end
