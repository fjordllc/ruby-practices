# frozen_string_literal: true

def set_files_horizontally
  files_no_dot = Dir.entries('.').sort.grep_v(/^\./)

  # 最大列数を定義
  rows = 3

  # transposeに備えて配列の要素数を合わせる
  lines = (files_no_dot.size % rows).zero? ? (files_no_dot.size / rows) : (files_no_dot.size / rows) + 1
  files_horizontally = files_no_dot.each_slice(lines).to_a
  max_elements = files_horizontally.max_by(&:size).size

  files_horizontally.each do |arr|
    arr << nil while arr.size < max_elements
  end

  files_horizontally
end

def ls_command
  files_vertically = set_files_horizontally.transpose.each do |arr|
    arr.delete(nil)
  end

  max_chars_filename = files_vertically.flatten.max_by(&:length).length

  files_vertically.each do |arr|
    arr.each do |file|
      print file.ljust(max_chars_filename + 1)
    end
    print "\n"
  end
end

ls_command
