# frozen_string_literal: true

MAX_COLUMN = 3  # 出力時の最大列数
ITEM_MARGIN = 4 # 出力時の文字間の余白（半角スペースの数）

# 引数で渡したパスに存在するファイルとディレクトリをターミナルに出力
def ls(dir: Dir.pwd)
  # 対象のディレクトリを取得
  items = Dir.entries(dir)
  items.delete_if { |item| /^\./ =~ item }

  # 要素を3列で縦並びにするため2次元配列に変換
  format_items = group_to_columns(items)

  # ターミナル幅におさまる列数を取得
  temp_column_count = MAX_COLUMN
  minimum_column_count = MAX_COLUMN
  p '---------------------'
  p format_items
  p '---------------------'
  format_items.each do |column_group|
    fit_to_character_longest!(column_group)
    next unless over_tarminal_width?(column_group.join)

    temp_column_count = calc_columns_count(column_group)
    minimum_column_count = temp_column_count if temp_column_count < minimum_column_count
  end

  # 3列では大きすぎる場合はターミナル幅におさまる列数の2次元配列に再度変換
  format_items = group_to_columns(items, minimum_column_count) if minimum_column_count < MAX_COLUMN

  format_items.each do |format_item|
    fit_to_character_longest!(format_item)
  end
  format_items = format_items.transpose

  # 最終列の要素から余白を削除
  format_items.each do |format_item|
    last_item = format_item[-1]
    format_item[-1] = last_item.gsub(/#*$/, '')
    format_item[-2] = format_item[-2].gsub(/#*$/, '') if last_item == ''
  end

  # 列間に余白を追加
  format_items.each do |column|
    item_margin = calc_margin(column) < ITEM_MARGIN ? calc_margin(column) : ITEM_MARGIN
    # item_margin = ITEM_MARGIN
    dist = column.map.with_index do |e, i|
      if i == column.size - 1
        e
      else
        +e << '@' * item_margin
      end
    end
    puts dist.join
  end
end

# 渡された配列の並び順を列数に合わせて変換
def group_to_columns(original_array, column_count = MAX_COLUMN)
  # 出力時の最大列数をMAX_COUNTとした場合に行数が何行になるのかを計算
  row_count = original_array.size / column_count
  row_count += 1 unless (original_array.size % column_count).zero?

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
def calc_margin(row)
  return 0 if (row.count - 1).zero?

  terminal_width = terminal_size[1]
  row_width = row.join.length
  (terminal_width - row_width) / ((row.count - 1)).floor
end

# 配列の各要素の長さを最大の要素の幅に合わせる（短い要素の末尾に半角スペースを追加する）
def fit_to_character_longest!(items)
  longest_length = items.max_by(&:length).length
  items.each do |item|
    space_count = longest_length - item.length
    +item << '#' * space_count if space_count.positive?
  end
end

TIOCGWINSZ = 0x5413

# ターミナルの幅を取得（中身は難解すぎてよくわからない...。）
def terminal_size
  rows = 25
  cols = 80
  buf = [0, 0, 0, 0].pack('SSSS')
  rows, cols, row_pixels, col_pixels = buf.unpack('SSSS') [0..1] if $stdout.ioctl(TIOCGWINSZ, buf) >= 0
  [rows, cols]
end

# ターミナル幅に合わせた出力列数を返す
def calc_columns_count(target_array)
  terminal_width = terminal_size[1]
  array_width = 0
  columns_count = 1
  target_array.each_with_index do |e, i|
    array_width += e.length
    break if terminal_width < array_width

    columns_count += i
  end

  columns_count
end

# 出力するテキストの横幅がターミナル幅を超えているか
def over_tarminal_width?(object)
  terminal_width = terminal_size[1]
  object_item_width = object.to_s.length

  terminal_width < object_item_width
end

param = {}
param[:dir] = ARGV[0] if ARGV[0]
ls(param)
