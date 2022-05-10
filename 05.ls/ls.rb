#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# オプション
dir_name = '.'
opt = OptionParser.new
opt.parse!(ARGV) # オプション以外の引数をARGVに代入
dir_name = ARGV[0] if ARGV[0]

# ディレクトリ情報取得
files = []

# ls デフォルト
def defo_ls(dir_name, files)
  exit_dir = Dir.exist?(dir_name)
  if exit_dir
    Dir.open(dir_name).each_child do |f|
      files << f unless f.start_with?('.')
    end
  else
    puts "#{dir_name}: No such file or directory"
  end
end

# ls -aオプション
# Dir.open(dir_name).each{|f|
#   p f
#   #files << f
# }

# 並び替え
def row_count(file)
  if (file.size % 3).zero?
    file.size / 3
  else
    file.size / 3 + 1
  end
end

# 出力
defo_ls(dir_name, files)
count = row_count(files)
files_sort = files.sort
files_sort.each_with_index do |file, i|
  if i < count
    print "#{file.ljust(10)} #{files_sort[i + count].ljust(10) if files_sort[i + count]} #{files_sort[i + count * 2].ljust(10) if files_sort[i + count * 2]}"
    puts ''
  end
end
