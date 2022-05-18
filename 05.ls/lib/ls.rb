# frozen_string_literal: true

require 'io/console'
require 'etc'

MAX_COLUMN_COUNT = 3 # 出力時の最大列数
MAX_ITEM_MARGIN = 2 # 出力時の文字間の最大余白（半角スペースの数）
TERMINAL_RIGHT_PADDING = 3 # ターミナル右端の余白

# 引数で渡したパスに存在するファイルとディレクトリをターミナルに出力
def ls(param)
  # 対象ディレクトリを取得
  Dir.chdir(param[:dir]) if param[:dir]

  # オプションの適用
  options = apply_options(param[:options])

  # lオプションがあれば成型せずに1列で出力
  if param[:options].grep(/l/).length >= 1
    options.each { |row| puts row }
  else
    formatted_array = ls_format_items(options)
    # 出力
    formatted_array.each { |row| puts row.join }
  end
end

# オプションの適用
def apply_options(options)
  # -aオプションの有無
  original_array = Dir.glob('*', options.grep(/a/).length >= 1 ? File::FNM_DOTMATCH : 0).sort
  # -rオプションの判定
  original_array.reverse! if options.grep(/r/).length >= 1
  # -lオプションの判定
  original_array = apply_l_option(original_array) if options.grep(/l/).length >= 1

  original_array
end

# 成型全般
def ls_format_items(original_array)
  columns = group_elments_by_columns(original_array)

  fit_columns = columns.map do |column|
    fit_to_longest_item(column)
  end

  # 行と列を転置した配列を作成
  rows = fit_columns.transpose.map do |row|
    # テキストが存在する最後列から余白を削除
    row.delete_if(&:empty?)
    row[-1].gsub!(/\s*$/, '')
    row
  end

  # 各列間に余白を付与
  margin = calc_margin(rows)
  add_column_margin(rows, margin)
end

# ターミナル幅におさまる列数を計算しその列数に合わせて行毎にまとめた配列を返す
def group_elments_by_columns(original_array)
  terminal_width = IO.console.winsize[1] - TERMINAL_RIGHT_PADDING

  column_count = MAX_COLUMN_COUNT
  # 元の配列をターミナル幅におさまる列数に分割した配列を取得
  loop do
    row_count = (original_array.size.to_f / column_count).ceil
    # 計算した行数に合わせて要素を二次元配列でまとめた配列を返す
    columns = original_array.each_slice(row_count).map do |column|
      column.fill('', column.size, row_count - column.size)
    end
    # 出力されるテキストの最大幅を取得
    max_size_row = columns.map do |column|
      column.max_by(&:length)
    end

    # アイテム間の余白も追加
    margin = max_size_row.size - 1

    break columns if max_size_row.join.length + margin < terminal_width || column_count <= 1

    column_count += -1
  end
end

# 出力時のファイル間の余白をターミナル幅から計算
def calc_margin(rows)
  max_length_row = rows.max_by { |row| row.join.length }
  # 1列しかなければ余白0を返す
  return 1 if max_length_row.size == 1

  terminal_width = IO.console.winsize[1] - TERMINAL_RIGHT_PADDING
  margin = (terminal_width - max_length_row.join.length) / ((max_length_row.size - 1)).floor
  margin < MAX_ITEM_MARGIN ? margin : MAX_ITEM_MARGIN
end

# 配列の各要素の長さを最大の要素の幅に合わせる（短い要素の末尾に半角スペースを追加する）
# 引数：配列
# 戻り値：最長の要素に合わせて各要素に半角スペースを追加した配列
def fit_to_longest_item(items, right_aligned: false)
  longest_length = items.max_by(&:length).length
  items.map do |item|
    space_count = longest_length - item.length
    if space_count.positive?
      if right_aligned
        item.rjust(longest_length)
      else
        item.ljust(longest_length)
      end
    else
      item
    end
  end
end

# アイテム間の余白付与
def add_column_margin(columns, margin)
  columns.map do |column|
    column.map.with_index do |item, i|
      i == column.size - 1 ? item : item + "\s" * margin
    end
  end
end

# lオプションがあった場合の処理
def apply_l_option(original_array)
  total_blocks = 0
  l_array = original_array.map do |item|
    new_item = []
    item_path = "#{Dir.getwd}/#{item}"
    item_info = File.lstat(item_path)

    new_item << format_filemode(format('%06d', item_info.mode.to_s(8)))
    total_blocks += item_info.blocks unless new_item[0].slice(0) == 'l'
    new_item << item_info.nlink.to_s
    new_item << Etc.getpwuid(item_info.uid).name
    new_item << Etc.getgrgid(item_info.gid).name
    new_item << item_info.size.to_s
    new_item << item_info.ctime.strftime('%b %d %k:%M')
    # シンボリックリンクの場合ターゲット名も出力する
    new_item << (new_item[0].slice(0) == 'l' ? "#{item} -> #{File.readlink(item_path)}" : item)
  end

  # 文字数を合わせる処理
  formatted_l_array = l_array.transpose.map.with_index do |row, i|
    # 最後の列（ファイル名）以外は右揃えにする
    i == l_array[0].size - 1 ? row : fit_to_longest_item(row, right_aligned: true)
  end.transpose

  formatted_l_array.map { |item| item.join(' ') }.unshift("total #{total_blocks / 2}")
end

# lオプションのファイルモードの出力整形
FILE_TYPES = {
  '01' => 'p',
  '02' => 'c',
  '04' => 'd',
  '06' => 'b',
  '10' => '-',
  '12' => 'l',
  '14' => 's'
}.freeze
PERMISSIONS = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze
def format_filemode(octal)
  filemode = []

  filemode << FILE_TYPES[octal.slice(0..1)]
  octal.slice(3..5).each_char do |s|
    filemode << PERMISSIONS[s]
  end
  filemode.join
end

# ターミナルから引数を取得しlsを実行
param = {}
param[:options] = []

ARGV.each do |option|
  case option
  when /^-[a-zA-Z]+/
    param[:options] << option
  else
    param[:dir] = option
  end
end

ls(**param)
