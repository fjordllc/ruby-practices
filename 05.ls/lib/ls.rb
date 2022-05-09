# frozen_string_literal: true


require 'io/console'



MAX_COLUMN_COUNT = 3 # 出力時の最大列数

MAX_ITEM_MARGIN = 2 # 出力時の文字間の最大余白（半角スペースの数）

TERMINAL_RIGHT_PADDING = 3 # ターミナル右端の余白



# 引数で渡したパスに存在するファイルとディレクトリをターミナルに出力

def ls(param)

  # 対象ディレクトリを取得

  Dir.chdir(param[:dir]) if param[:dir]



  # -aオプションの判定

  original_array = Dir.glob('*', param[:options].grep(/a/).length >= 1 ? File::FNM_DOTMATCH : 0)



  # -rオプションの判定

  original_array.reverse! if param[:options].grep(/r/).length >= 1



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

  formatted_array = add_column_margin(rows, margin)



  # 出力

  formatted_array.each { |row| puts row.join }

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

def fit_to_longest_item(column)

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

