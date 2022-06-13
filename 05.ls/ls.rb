# frozen_string_literal: true

MAX_NUMBER_OF_COLUMNS = 3

stdin = ARGV[0]
target_name = stdin || '.'

def main(directory_contents)
  display_width = calculate_display_width(directory_contents)
  array_for_display = create_array_for_display(directory_contents)

  print_filename(array_for_display, display_width)
end

def calculate_display_width(directory_contents)
  filename_length_array = directory_contents.map do |filename|
    # 非ascii文字は表示幅が+1になる
    filename.length + filename.chars.count { |x| !x.ascii_only? }
  end
  filename_length_array.max + 5
end

def create_array_for_display(directory_contents)
  # 等差数列で表示するための公差(common difference)を求める
  common_difference = (directory_contents.length / MAX_NUMBER_OF_COLUMNS.to_f).ceil

  directory_contents_divided_per_common_difference =
    directory_contents.each_slice(common_difference).to_a

  # TODO: 変数名をtransposedに変更する 修正後このコメントは削除する
  directory_contents_sorted_for_display = Array.new(common_difference) do
    directory_contents_divided_per_common_difference.map(&:shift)
  end

  directory_contents_sorted_for_display.map do |row|
    row.map { |filename| filename.nil? ? ' ' : filename }
  end
end

def print_filename(array_for_display, display_width)
  array_for_display.each do |row|
    row.each do |file|
      number_of_not_ascii_character = file.chars.count { |x| !x.ascii_only? }
      print file.ljust(display_width - number_of_not_ascii_character)
    end
    puts "\n"
  end
end

def validate_file_or_directory(target_name)
  filetype = File.ftype(target_name)
  case filetype
  when 'directory'
    Dir.glob('*', base: target_name, sort: true)
  when 'file'
    [File.basename(target_name)]
  end
rescue SystemCallError
  puts '存在するディレクトリ名もしくはファイル名を指定してください'
  raise
end

directory_contents = validate_file_or_directory(target_name)
main(directory_contents)
