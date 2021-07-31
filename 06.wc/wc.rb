# frozen_string_literal: true

require 'optparse'

# getoptsしたあとは指定したオプションがARGVの配列から取り除かれる
@option = ARGV.getopts('l')

def main
  if ARGV.empty?
    stdin = $stdin.readlines
    stdin_result(stdin)
  else
    file_result(ARGV)
  end
end

# 各計算結果の表記は8桁で揃える
RESULT_WORD_WIDTH = 8

# パイプで入力がある場合の計算
def stdin_count_lines(stdin)
  stdin.size
end

def stdin_count_words(stdin)
  stdin.join.split(/\n|\t| +|　+/).size
end

def stdin_measure_byte(stdin)
  stdin.join.size
end

def stdin_result(stdin)
  if @option['l']
    puts stdin_count_lines(stdin).to_s.rjust(RESULT_WORD_WIDTH)
  else
    puts stdin_count_lines(stdin).to_s.rjust(RESULT_WORD_WIDTH) + \
         stdin_count_words(stdin).to_s.rjust(RESULT_WORD_WIDTH) + \
         stdin_measure_byte(stdin).to_s.rjust(RESULT_WORD_WIDTH)
  end
end

# 引数でファイルを指定した場合の計算
def file_count_lines(file)
  lines_number = File.read(file).each_line.count
  lines_number.to_s.rjust(RESULT_WORD_WIDTH)
end

def file_count_words(file)
  words_number = File.read(file).split(/\n| /).count
  words_number.to_s.rjust(RESULT_WORD_WIDTH)
end

def file_measure_byte(file)
  byte_size = File.size(file)
  byte_size.to_s.rjust(RESULT_WORD_WIDTH)
end

def file_result(file_list)
  lines_sum = 0
  words_sum = 0
  byte_sum = 0

  file_list.each do |file|
    if @option['l']
      puts "#{file_count_lines(file)} #{file}"
    else
      puts "#{file_count_lines(file)}#{file_count_words(file)}#{file_measure_byte(file)} #{file}"
    end
    lines_sum += file_count_lines(file).to_i
    words_sum += file_count_words(file).to_i
    byte_sum += file_measure_byte(file).to_i
  end

  return unless file_list.size >= 2

  if option['l']
    puts "#{lines_sum.to_s.rjust(RESULT_WORD_WIDTH)} total"
  else
    puts "#{lines_sum.to_s.rjust(RESULT_WORD_WIDTH)}#{words_sum.to_s.rjust(RESULT_WORD_WIDTH)}#{byte_sum.to_s.rjust(RESULT_WORD_WIDTH)} total"
  end
end

main
