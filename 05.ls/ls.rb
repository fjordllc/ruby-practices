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
  if Dir.exist?(dir_name)
    files = if option == '-a'
              Dir.glob('*', File::FNM_DOTMATCH, base: dir_name)
            else
              Dir.glob('*', base: dir_name)
            end
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
