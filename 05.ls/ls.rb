#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# オプション
dir_name = ARGV[0] ? "#{ARGV[0]}/*" : '*'

# ディレクトリ情報取得
files = []

# ls デフォルト
def defo_ls(dir_name, files)
  dir_exist = Dir.exist?(ARGV[0] || '.')
  if dir_exist
    Dir.glob(dir_name) do |f|
      files << f.gsub("#{ARGV[0]}/", '')
    end
  else
    puts "#{ARGV[0]}: No such file or directory"
  end
end

# ls -aオプション
# Dir.glob("*", File::FNM_DOTMATCH)

# 出力
defo_ls(dir_name, files)
count = (files.size / 3.0).ceil(0)
files_sort = files.sort
count.times do |i|
  print files_sort[i].ljust(12).to_s
  print files_sort[i + count].ljust(12).to_s if files_sort[i + count]
  print files_sort[i + count * 2].ljust(12).to_s if files_sort[i + count * 2]
  puts ''
end
