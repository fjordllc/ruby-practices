#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# オプション
dir_name = ARGV[0] || '.'

# ディレクトリ情報取得
files = []

# ls デフォルト
def defo_ls(dir_name, files)
  if Dir.exist?(dir_name)
    Dir.glob('*', base: dir_name).each do |f|
      files << f
    end
  else
    puts "#{dir_name}: No such file or directory"
  end
end

# ls -aオプション
# Dir.glob("*", File::FNM_DOTMATCH)

# 出力
defo_ls(dir_name, files)
count = (files.size / 3.0).ceil(0)
files_sort = files.sort
count.times do |i|
  3.times do |j|
    result = files_sort[i + j * count]
    print result.ljust(12).to_s if result
  end
  puts ''
end
