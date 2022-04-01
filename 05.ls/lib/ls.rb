# frozen_string_literal: true

MAX_COLUMN = 3  # 出力時の最大列数
ITEM_MARGIN = 4 # 出力時の文字間の余白（半角スペースの数）

# 引数で渡したパスに存在するファイルとディレクトリをターミナルに出力
def ls(dir: Dir.pwd)
  items = Dir.entries(dir)
  items.delete_if { |item| /^\./ =~ item }
  group_to_columns(items).each do |column|
    puts column.join
  end
end

# 渡された配列の並び順を変換して出力用にフォーマットされた配列を返す
def group_to_columns(original_array)
  # 出力時の最大列数をMAX_COUNTとした場合に行数が何行になるのかを計算
  row_count = original_array.size / MAX_COLUMN
  row_count += 1 unless (original_array.size % MAX_COLUMN).zero?

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

  # 出力時の要素の並び順を以下のように縦並びにするための処理
  # 1 5 9
  # 2 6 10
  # 3 7
  # 4 8
  columns.each do |item|
    # 各要素に文字間の余白を追加
    fit_to_character_longest(item).map { |e| +e << ' ' * ITEM_MARGIN }
  end.transpose
end

# 配列の各要素の長さを最大の要素の幅に合わせる（短い要素の末尾に半角スペースを追加する）
def fit_to_character_longest(items)
  longest_length = items.max_by(&:length).length
  items.each do |item|
    space_count = longest_length - item.length
    +item << ' ' * space_count if space_count.positive?
  end
end

param = {}
param[:dir] = ARGV[0] if ARGV[0]
ls(param)
