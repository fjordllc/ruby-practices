#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# オプション
option = ''
opt = OptionParser.new
opt.on('-a') { option = '-a' }
opt.parse!(ARGV)
dir_name = ARGV[0] || '.'

# ディレクトリ情報取得
files = []

# ls デフォルト
def ls_cmd(dir_name, files, option)
  dotmatch = option == '-a' ? File::FNM_DOTMATCH : 0
  if Dir.exist?(dir_name)
    files = Dir.glob('*', dotmatch, base: dir_name)
    count = (files.size / 3.0).ceil(0)
    files_sort = files.sort
    count.times do |i|
      3.times do |j|
        result = files_sort[i + j * count]
        print result.ljust(12).to_s if result
      end
      puts ''
    end
  else
    puts "#{dir_name}: No such file or directory"
  end
end

# 出力
ls_cmd(dir_name, files, option)
