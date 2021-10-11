# frozen_string_literal: true

require 'etc'
require 'optparse'

def main
  option = ARGV.getopts('alr')
  scope = option['a'] ? File::FNM_DOTMATCH : File::FNM_PATHNAME
  if option['l']
    ls_l(scope: scope, reverse: option['r'])
  else
    ls(scope: scope, reverse: option['r'])
  end
end

# File.statで受け取ったファイルタイプの表記を変換する
def convert_to_ftype(file)
  {
    'file' => '-',
    'directory' => 'd',
    'link' => 'l',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'socket' => 's',
    'fifo' => 'p'
  }[file.ftype]
end

# File.statで受け取ったファイルモードの表記を変換する
def convert_to_fmode(file, position)
  {
    7 => 'rwx',
    6 => 'rw-',
    5 => 'r-x',
    4 => 'r--',
    3 => '-wx',
    2 => '-w-',
    1 => '--x',
    0 => '---'
  }[file.mode.to_s(8).slice(position).to_i]
end

# 最大幅3列にする場合の1列の要素数を計算する
# 余りが出る場合は商+1が1列の要素数
def count_clumn_item(num)
  quotient, remainder = num.divmod(3)
  remainder.zero? ? quotient : quotient + 1
end

def ls(scope: File::FNM_PATHNAME, reverse: false)
  file_list = reverse ? Dir.glob('*', scope).reverse : Dir.glob('*', scope)

  # ファイル名の最大数を取得する
  max_size = file_list.max_by(&:length).size

  # 3列で並べる際の1列の要素数を求める
  slice_num = count_clumn_item(file_list.size)

  # 1列に入る要素数で配列を区切り、行と列を入れ替える
  file_list_transposed = file_list.each_slice(slice_num).to_a.map! { |it| it.values_at(0...slice_num) }.transpose

  # 3列表示にするために並び替えて格納した配列
  file_list_ajusted = file_list_transposed.map do |list_line|
    list_line.map do |list_line_item|
      # ファイル名を最大数の幅に揃える
      list_line_item.nil? ? ' '.ljust(max_size) : list_line_item.ljust(max_size)
    end.join
  end
  puts file_list_ajusted
end

def ls_l(scope: File::FNM_PATHNAME, reverse: false)
  file_blocks = 0
  file_list = Dir.glob('*', scope).map do |file_item|
    stat = File.stat(file_item)
    file_type = convert_to_ftype(stat)
    file_mode = convert_to_fmode(stat, -3) + convert_to_fmode(stat, -2) + convert_to_fmode(stat, -1)
    file_type_mode = file_type + file_mode
    hard_link = stat.nlink.to_s.rjust(2)
    owner_name = Etc.getpwuid(stat.uid).name
    group_name = Etc.getgrgid(stat.gid).name
    file_size = stat.size.to_s.rjust(5)
    month = stat.mtime.strftime('%m').rjust(2)
    day = stat.mtime.strftime('%d')
    time = stat.mtime.strftime('%H:%M')
    file_name = file_item
    file_blocks += stat.blocks
    "#{file_type_mode} #{hard_link} #{owner_name} #{group_name} #{file_size} #{month} #{day} #{time} #{file_name}"
  end

  puts "total #{file_blocks}"
  puts reverse ? file_list.reverse : file_list
end

main
