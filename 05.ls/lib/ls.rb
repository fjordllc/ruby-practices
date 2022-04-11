# frozen_string_literal: true

MAX_COLUMN_COUNT = 3 # 出力時の最大列数
MAX_ITEM_MARGIN = 2 # 出力時の文字間の最大余白（半角スペースの数）
TERMINAL_RIGHT_PADDING = 3 # ターミナル右端の余白

# 引数で渡したパスに存在するファイルとディレクトリをターミナルに出力
def ls(dir: Dir.pwd)
  Dir.chdir(dir)
  # 対象のディレクトリを取得
  original_array = Dir.glob('*')

  # 3列に成型
  formatted_array = format_array_to_output(original_array)
  # ターミナル幅に合わせたカラム数を計算
  column_count = calc_column_count(formatted_array)

  formatted_array = format_array_to_output(original_array, column_count) if column_count < MAX_COLUMN_COUNT

  # 各行を出力
  formatted_array.each { |row| puts row.join }
end

# 配列の成型全般
def format_array_to_output(original_array, column_count = MAX_COLUMN_COUNT)
  # 行を列に転置するために列ごとに要素をまとめた2次元配列を作成
  columns = group_to_columns(original_array, column_count)

  # 列毎に要素の長さを合わせる
  fit_columns = columns.map do |column|
    fit_to_longest_column_item(column)
  end

  # 行と列を転置した配列を作成
  rows = fit_columns.transpose.map do |row|
    # テキストが存在する最後列から余白を削除
    row.delete_if { |item| item.match(/^\s*$/) }
    row[-1].gsub!(/\s*$/, '')
    row
  end

  # 各列間に余白を付与
  margin = calc_margin(rows)
  add_column_margin(rows, margin)
end

# 渡された配列の並び順を列数に合わせて変換
def group_to_columns(original_array, column_count = MAX_COLUMN_COUNT)
  # 出力時の最大列数をMAX_COUNTとした場合に行数が何行になるのかを計算
  row_count = (original_array.size.to_f / column_count).ceil

  columns = [] # 出力時の縦列に相当する配列
  column = []  # 各列の要素をまとめる配列

  # original_arrayの各要素をrow_count個ずつ配列としてまとめてcolumnsの要素にする
  original_array.each.with_index(1) do |item, i|
    column << item
    if (i % row_count).zero?
      columns << column
      column = []
    elsif i == original_array.size
      (row_count - column.size).times { column << '' }
      columns << column
    end
  end

  columns
end

# 出力時のファイル間の余白をターミナル幅から計算
def calc_margin(rows)
  max_length_row = rows.max_by { |row| row.join.length }
  # 1列しかないorターミナル幅を行の長さが超えていたら余白0を返す
  return 1 if max_length_row.size == 1 || !within_tarminal_width?(max_length_row.join)

  terminal_width = terminal_size[1] - TERMINAL_RIGHT_PADDING
  margin = (terminal_width - max_length_row.join.length) / ((max_length_row.size - 1)).floor
  margin < MAX_ITEM_MARGIN ? margin : MAX_ITEM_MARGIN
end

# 配列の各要素の長さを最大の要素の幅に合わせる（短い要素の末尾に半角スペースを追加する）
# 引数：列にあたる配列
# 戻り値：最長の要素に合わせて各要素に半角スペースを追加した配列
def fit_to_longest_column_item(column)
  longest_length = column.max_by(&:length).length
  column.map do |item|
    space_count = longest_length - item.length
    space_count.positive? ? item + "\s" * space_count : item
  end
end

def add_column_margin(columns, margin)
  columns.map do |column|
    column.map.with_index do |item, i|
      i == column.size - 1 ? item : item + "\s" * margin
    end
  end
end

TIOCGWINSZ = 0x5413

# ターミナルの幅を取得（中身は難解すぎてよくわからない...。）
def terminal_size
  rows = 25
  cols = 80
  buf = [0, 0, 0, 0].pack('SSSS')
  rows, cols, row_pixels, col_pixels = buf.unpack('SSSS') [0..1] if $stdout.ioctl(TIOCGWINSZ, buf) >= 0
  [rows, cols, row_pixels, col_pixels]
end

# ターミナル幅に合わせた出力列数を返す
# 引数：配列
# 戻り値：列数（数値）
def calc_column_count(rows)
  terminal_length = terminal_size[1] - TERMINAL_RIGHT_PADDING
  max_length_row = rows.max_by { |row| row.join.length }
  return MAX_COLUMN_COUNT if within_tarminal_width?(max_length_row.join)

  row_length = 0
  column_count = 1
  max_length_row.each_with_index do |item, i|
    row_length += item.length
    break if terminal_length < row_length

    column_count += i
  end
  column_count < MAX_COLUMN_COUNT ? column_count : MAX_COLUMN_COUNT
end

# 出力するテキストの横幅がターミナル幅を超えているか
def within_tarminal_width?(object)
  terminal_width = terminal_size[1] - TERMINAL_RIGHT_PADDING
  object_item_width = object.to_s.length
  terminal_width > object_item_width
end

# ターミナルから引数を取得しlsを実行
param = {}
param[:dir] = ARGV[0] if ARGV[0]
ls(param)
