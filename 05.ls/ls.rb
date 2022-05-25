#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# ネットで見つけた崩れないljust
class String
  def mb_ljust(width, padding = ' ')
    output_width = each_char.map { |c| c.bytesize == 1 ? 1 : 2 }.reduce(0, &:+)
    padding_size = [0, width - output_width].max
    self + padding * padding_size
  end
end

# オプション
option = []
opt = OptionParser.new
opt.on('-a') { option << 'a' }
opt.on('-r') { option << 'r' }
opt.parse!(ARGV)
dir_name = ARGV[0] || '.'

# ディレクトリ情報取得
files = []

# lsコマンド
def ls_cmd(dir_name, files, option)
  dotmatch = option.include?('a') ? File::FNM_DOTMATCH : 0
  if Dir.exist?(dir_name)
    files = Dir.glob('*', dotmatch, base: dir_name, sort: true)
    count = (files.size / 3.0).ceil(0)
    files_sort = option.include?('r') ? files.sort.reverse : files
    count.times do |i|
      3.times do |j|
        result = files_sort[i + j * count]
        print result.mb_ljust(12).to_s if result
      end
      puts ''
    end
  else
    puts "#{dir_name}: No such file or directory"
  end
end

# 出力
ls_cmd(dir_name, files, option)
