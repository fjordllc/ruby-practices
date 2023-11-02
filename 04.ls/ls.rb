#!/usr/bin/env ruby
# frozen_string_literal: true

# 表示列
DISPLAY_COLUMN = 3

#
# 取得したファイル群を表示順に2次元配列に格納する。
# 引数 : files[class:Array]
# 戻り値 : display[class:Array]
#
def store_display(files)
  display = setup_array(files)
  # ファイル名が最も長いファイル名の文字数を取得する
  max_file_name_length = files.map(&:size).max
  cnt = 0
  # ディスプレイ表示順で2次元配列にセットする。
  catch :files_end do
    0...DISPLAY_COLUMN.times do |column|
      0...display.size.times do |row|
        if column != DISPLAY_COLUMN - 1
          display[row][column] = files[cnt].ljust(max_file_name_length + 3) if !files[cnt].nil?
        else
          display[row][column] = files[cnt]
        end
        throw :files_end if cnt == files.size - 1
        cnt += 1
      end
    end
  end
  display
end

#
# ファイルの数に合わせた2次元配列をセットアップする
# 引数：files[class:Array]
# 戻り値：ファイルの数に合わせた2次元配列[class:Array]
#
def setup_array(files)
  quotient, remainder = files.size.divmod(DISPLAY_COLUMN)
  # ファイルの数に応じた2次元配列を用意
  row = if remainder.zero?
          quotient
        else
          quotient + 1
        end
  Array.new(row) { Array.new(DISPLAY_COLUMN, '') }
end

#
# 2次元配列に格納された値をターミナルに出力する
# 引数 : display(class:Array)
# 戻り値 : なし
#
def output_display(display)
  output_display = Array.new(display.size, '')
  0...display.size.times do |row|
    0...DISPLAY_COLUMN.times do |column|
      output_display[row] = output_display[row] + display[row][column]
    end
    puts output_display[row]
  end
end

files = Dir.glob('*')
display = store_display(files)
output_display(display)
