require 'optparse'
require 'debug'

#カレントディレクトリの情報を取得
def main
  current_dir = Dir.glob("*").sort
  make_array(current_dir)
end

#配列を最大３列に並べる
def make_array(current_dir)
  #縦横の指定をする
  max_row = 3.0
  total_file_size = current_dir.size
  columns = (total_file_size / max_row).ceil

  #配列の用意
  arrays =[]
  current_dir.each_slice(columns) do |list_of_file|
    arrays << list_of_file
    #flattenを使用するため最大要素数までnilを配列に詰める
    max_size = arrays.map(&:size).max
    arrays.map! { |element| element.values_at(0...max_size) }
  end
  show_files(arrays)
end

#表示する
def show_files(arrays)
  transposed_array = arrays.transpose
  transposed_array.each do |two_dimensional_array|
    two_dimensional_array.each do |file|
     print "#{file}".ljust(25)
    end
    print  "\n"
  end
end

main
