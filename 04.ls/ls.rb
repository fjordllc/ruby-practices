def justify_files
  files = Dir.glob('*').sort
  max_length = files.map(&:size).max
  files.map { |file| file.ljust(max_length + 5) }
end

# 3つの行の二次元配列に直す関数
def convert_to_rows(array, number_of_rows)
  rows = (array.length / number_of_rows.to_f).ceil
  array.each_slice(rows).to_a
end

# 列数が揃わないところに空文字を挿入して列数を揃える関数
def align_columns(array, number_of_columns)
  array[-1] += [''] * (number_of_columns - array[-1].length)
  array
end

# ファイルを取得して整形
files = get_and_justify_files

# 表示する行数を指定
number_of_lines = 3

# 3つの行の二次元配列に変換
files_in_rows = convert_to_rows(files, number_of_lines)

# 列数が揃わないところに空文字を挿入して列数を揃える
files_in_rows = align_columns(files_in_rows, files_in_rows[0].length)

# transpose、eachを使って変数に代入、改行を加えて出力
transposed_files = files_in_rows.transpose
transposed_files.each do |row|
  puts row.join
end
