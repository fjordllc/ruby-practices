#!/usr/bin/env ruby

require 'optparse'
require 'etc'

# NOTE: -aオプション指定ではFile::FNM_DOTMATCHを指定するがオプションなしの初期値として0指定
a_option_flag = 0
# NOTE: -rオプション指定ではtrueを代入
r_option_flag = false
# NOTE: -lオプション指定ではtrueを代入
l_option_flag = false

dir_items_list = []
details_of_dir_items = {}
# NOTE: デフォルト値として定数定義をし定数を初期値として利用するために追加
DEFAULT_HORIZONAL_ITEMS_COUNT = 3
DEFAULT_OUTPUT_ITEM_WIDTH = 10
DEFAULT_ITEMS_INTERVAL = 5

horizontal_items_count = DEFAULT_HORIZONAL_ITEMS_COUNT
output_item_width = DEFAULT_OUTPUT_ITEM_WIDTH
items_interval = DEFAULT_ITEMS_INTERVAL

class String
  # NOTE: Stringクラスにマルチバイトに対応したljustメソッドが存在しなかったため追加
  def mb_ljust(width, padding = ' ')
    char_size = each_char.map { |s| s.bytesize == 1 ? 1 : 2 }.inject(:+)
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

def ls_print(target, item_width, ls_opt, target_details)
  # TODO: -l オプション時に詳細を取得する処理を書く
  puts "total #{(target_details[:block_total] / 1024).to_i}" if ls_opt
  target.each do |line_items|
    line_items.each do |line_item|
      if ls_opt
        # HACK: 所有者やグループ、ダイルサイズは文字列の最大から余白を取りたいが今回は本質ではないと思い余白固定で割愛
        print target_details[line_item][:mode]
        print target_details[line_item][:link_num].to_s.rjust(3)
        print target_details[line_item][:owner].rjust(10)
        print target_details[line_item][:own_grp].rjust(10)
        print target_details[line_item][:size].to_s.rjust(8)
        print target_details[line_item][:updated_m].to_s.rjust(3)
        print target_details[line_item][:updated_d].to_s.rjust(3)
        print "#{target_details[line_item][:updated_t].to_s.rjust(6)} "
      end
      print line_item.mb_ljust(item_width)
    end
    puts
  end
end

def change_mode_2_perm(path, mode_num)
  perm_num = mode_num.slice(-3..-1)
  permission = File.directory?(path) ? 'd' : '-'
  perm_num.each_char do |char|
    # HACK: 8進数のmodeをパーミッション型に変換する良い方法を別途考える必要あり
    permission << case char
                  when '7'
                    'rwx'
                  when '6'
                    'rw-'
                  when '5'
                    'r-x'
                  when '4'
                    'r--'
                  when '3'
                    '-wx'
                  when '2'
                    '-w-'
                  when '1'
                    '--x'
                  else
                    '---'
                  end
  end
  permission
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
  opt.on('-l', '--list', 'show items details') do
    l_option_flag = true
    horizontal_items_count = 1
  end
  opt.on('-h', '--help', 'show this help') do
    puts opt
    exit
  end
  opt.parse!(ARGV)

  # NOTE: 通常のlsは複数のパス指定に対応するため ./ls.rb <path> -a などでくると
  # NOTE: <path>分は検索をかけて表示し-aは不正なパス指定としてエラーを出すが今回は複数対応していないため割愛
  ls_target_path = if ARGV[-1].nil? || ARGV[-1].start_with?('-')
                     '.'
                   else
                     ARGV[-1]
                   end

  if FileTest.directory?(ls_target_path)
    Dir.glob('*', flags: a_option_flag, base: ls_target_path) do |item_in_dir|
      stat = File.stat(item_in_dir)
      details_of_dir_items[item_in_dir] =
        { mode: change_mode_2_perm(item_in_dir, stat.mode.to_s(8)), link_num: stat.nlink, owner: Etc.getpwuid(stat.uid).name,
          own_grp: Etc.getgrgid(stat.gid).name, size: stat.size, updated_m: stat.mtime.month, updated_d: stat.mtime.day,
          updated_t: stat.mtime.strftime('%I:%M') }
      dir_items_list << item_in_dir
      block_total = FileTest.file?(item_in_dir) ? stat.size : 0
      # NOTE: 表示アイテムの最大文字列とアイテム間のスペースがoutput_item_widthを超えていたらoutput_item_widthを更新する
      # NOTE: （補足）output_item_widthとは一つのアイテムが横幅でとってよい幅のこと
      output_item_width = [item_in_dir.bytesize + items_interval, output_item_width].max
      details_of_dir_items[:block_total] = details_of_dir_items[:block_total].nil? ? 0 : details_of_dir_items[:block_total] + block_total
    end
    sorted_dir_items_list = ls_sort(dir_items_list, horizontal_items_count, r_option_flag)
    ls_print(sorted_dir_items_list, output_item_width, l_option_flag, details_of_dir_items)

  elsif FileTest.file?(ls_target_path)
    dir_items_list << ls_target_path
    ls_print(dir_items_list, output_item_width)
  else
    raise StandardError, "ls: #{ls_target_path}: No such file or directory"
  end
  exit
rescue OptionParser::InvalidOption => e
  puts "ls: unrecognized option #{e.args[0]}"
  exit(1)
rescue StandardError => e
  print e.message
  puts
  exit(1)
end
