# frozen_string_literal: true

require 'etc'
require 'optparse'

def main
  option = ARGV.getopts('alr')
  if option['a'] && option['l'] && option['r']
    ls_l(scope: File::FNM_DOTMATCH, reverse: true)
  elsif option['a'] && option['l']
    ls_l(scope: File::FNM_DOTMATCH)
  elsif option['l'] && option['r']
    ls_l(reverse: true)
  elsif option['a'] && option['r']
    ls(scope: File::FNM_DOTMATCH, reverse: true)
  elsif option['a']
    ls(scope: File::FNM_DOTMATCH)
  elsif option['l']
    ls_l
  elsif option['r']
    ls(reverse: true)
  else
    ls
  end
end

# File.statで受け取ったファイルタイプの表記を変換する
FILETYPES = {
  'file' => '-',
  'directory' => 'd',
  'link' => 'l',
  'characterSpecial' => 'c',
  'blockSpecial' => 'b',
  'socket' => 's',
  'fifo' => 'p'
}.freeze

def file_type_conversion(file)
  FILETYPES[file.ftype]
end

# File.statで受け取ったファイルモードの表記を変換する
def file_mode_conversion(file, position)
  case file.mode.to_s(8).slice(position).to_i
  when 7
    'rwx'
  when 6
    'rw-'
  when 5
    'r-x'
  when 4
    'r--'
  when 3
    '-wx'
  when 2
    '-w-'
  when 1
    '--x'
  else
    '-0-7'
  end
end

# 最大幅3列にする場合の1列の要素数を計算する
# 余りが出る場合は商+1が1列の要素数
def clumn_item_count(num)
  quotient, remainder = num.divmod(3)
  if remainder.zero?
    quotient
  else
    quotient + 1
  end
end

def ls(scope: File::FNM_PATHNAME, reverse: false)
  file_list = []
  adjusted_file_list = []
  max_size = 0

  # 現在のディレクトリのファイルを配列に入れる
  Dir.glob('*', scope).each do |file_item|
    file_list << file_item

    # ファイル名の最大数を取得する
    max_size = file_item.size > max_size ? file_item.size : max_size
  end

  # reverseがtrueかfalseによって並び順を変える
  file_list_sorted = reverse == true ? file_list.sort.reverse : file_list.sort

  # 3列で並べる際の1列の要素数を求める
  slice_num = clumn_item_count(file_list_sorted.size)

  # 1列に入る要素数で配列を区切り、行と列を入れ替える
  file_list_transposed = file_list_sorted.each_slice(slice_num).to_a.map! { |it| it.values_at(0...slice_num) }.transpose

  file_list_transposed.each do |list_line|
    line_item = []

    # ファイル名を最大数の幅に揃える
    list_line.each do |list_line_item|
      line_item << (list_line_item.nil? ? ' '.ljust(max_size) : list_line_item.ljust(max_size))
    end

    # 3列表示にするために並び替えて格納した配列
    adjusted_file_list << line_item
  end

  adjusted_file_list.each do |adjusted_file_list_item|
    puts adjusted_file_list_item.join(' ')
  end
end

def ls_l(scope: File::FNM_PATHNAME, reverse: false)
  file_list = []
  Dir.glob('*', scope).each do |file_item|
    stat = File.stat(file_item)
    file_type = file_type_conversion(stat)
    file_mode = file_mode_conversion(stat, -3) + file_mode_conversion(stat, -2) + file_mode_conversion(stat, -1)
    file_type_mode = file_type + file_mode
    hard_link = stat.nlink.to_s.rjust(2)
    owner_name = Etc.getpwuid(stat.uid).name
    group_name = Etc.getgrgid(stat.gid).name
    file_size = stat.size.to_s.rjust(5)
    month = stat.mtime.strftime('%m月')
    day = stat.mtime.strftime('%d')
    time = stat.mtime.strftime('%H:%M')
    year = stat.mtime.strftime('%Y')
    file_name = file_item
    file_list << [file_type_mode, hard_link, owner_name, group_name, file_size, month, day, time, year, file_name]
  end

  file_list_sorted = reverse == true ? file_list.sort_by { |a| a[-1] }.reverse : file_list.sort_by { |a| a[-1] }

  # 配列の中の配列を,ではなく半角スペースで連結したものを1行ずつ表示する
  puts file_list_sorted.map! { |file_list_sorted_item| file_list_sorted_item.join(' ') }.join("\n")
end

main
