#!/usr/bin/env ruby

require 'optparse'

# NOTE: -aオプション指定ではFile::FNM_DOTMATCHを指定するがオプションなしの初期値として0指定
a_option_flag = 0
# NOTE: -rオプション指定ではtrueを代入
r_option_flag = false

dir_items_list = []
# NOTE: デフォルト値として定数定義をし定数を初期値として利用するために追加
DEFAULT_HORIZONAL_ITEMS_COUNT = 3
DEFAULT_OUTPUT_ITEM_WIDTH = 10
DEFAULT_ITEMS_INTERVAL = 5

horizontal_items_count = DEFAULT_HORIZONAL_ITEMS_COUNT
output_item_width = DEFAULT_OUTPUT_ITEM_WIDTH
items_interval = DEFAULT_ITEMS_INTERVAL

class String
  def mb_ljust(width, padding=' ')
    char_size = each_char.map{|s| s.bytesize == 1 ? 1 : 2}.inject(:+)
    padding_size = [0, width - char_size].max
    self + padding * padding_size
  end
end

def ls_sort(target_list, horizontal_num, sort_reverse)
  # NOTE: 行方向に昇順（-r では降順）表示にするために行方向の最大行数を取得
  max_vertical_items_count = (target_list.size.to_f / horizontal_num).ceil
  target_list = sort_reverse ? target_list.sort.reverse : target_list.sort
  sorted_list = []
  # NOTE: 一行ごとの隣り合うアイテムが最大行数ごとに並ぶように昇順（-r では降順）済みリストインデックスを並び替える
  max_vertical_items_count.times do |count|
    tmp_list_for_vertival_output = []
    target_list.each_with_index do |v, i|
      next if i % max_vertical_items_count != count

      tmp_list_for_vertival_output << v
    end
    sorted_list << tmp_list_for_vertival_output
  end
  sorted_list
end

def ls_print(target, item_width)
  # TODO: -l オプション時に詳細を取得する処理を書く
  target.each do |line_items|
    line_items.each do |line_item|
      print line_item.mb_ljust(item_width)
    end
    puts
  end
end

begin
  opt = OptionParser.new
  opt.on('-a', '--all', 'show all items') do
    a_option_flag = File::FNM_DOTMATCH
    # NOTE: Dir.globでは'..'の取得ができないため追加
    dir_items_list << '..'
  end
  opt.on('-r', '--reverse', 'show items in reverse order') do
    r_option_flag = true
  end
  opt.on('-h', '--help', 'show this help') do
    puts opt
    exit
  end
  opt.parse(ARGV)

  # NOTE: 通常のlsは複数のパス指定に対応するため ./ls.rb <path> -a などでくると
  # NOTE: <path>分は検索をかけて表示し-aは不正なパス指定としてエラーを出すが今回は複数対応していないため割愛
  ls_target_path = if ARGV[-1].nil? || ARGV[-1].start_with?('-')
                     '.'
                   else
                     ARGV[-1]
                   end

  if FileTest.directory?(ls_target_path)
    Dir.glob('*', flags: a_option_flag, base: ls_target_path) do |item_in_dir|
      dir_items_list << item_in_dir
      # NOTE: 表示アイテムの最大文字列とアイテム間のスペースがoutput_item_widthを超えていたらoutput_item_widthを更新する
      # NOTE: （補足）output_item_widthとは一つのアイテムが横幅でとってよい幅のこと
      output_item_width = [item_in_dir.bytesize + items_interval, output_item_width].max
    end
    sorted_dir_items_list = ls_sort(dir_items_list, horizontal_items_count, r_option_flag)
    # TODO: -rオプションの際にASC処理ではなくDESC処理をする
    ls_print(sorted_dir_items_list, output_item_width)

  elsif FileTest.file?(ls_target_path)
    dir_items_list << ls_target_path
    ls_print(dir_items_list, output_item_width)
  else
    raise StandardError, "ls: #{ls_target_path}: No such file or directory"
  end
  exit
rescue OptionParser::InvalidOption => e
  puts "ls: unrecognized option `#{e.args[0]}'"
  exit(1)
rescue StandardError => e
  print e.message
  puts
  exit(1)
end
