#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

DEFAULT_PATH = '.'
COLUMNS_SIZE = 3
PADDING_SIZE = 1

def execute(path, options:)
  flags = options['a'] ? File::FNM_DOTMATCH : File::FNM_SYSCASE
  entries = Dir.glob('*', flags, base: path)
  entries = entries.reverse if options['r']
  output(entries, column_size: COLUMNS_SIZE)
end

def output(entries, column_size: COLUMNS_SIZE)
  return if entries.empty? # 空のディレクトリは出力なし

  column_width = entries.map(&:size).max + PADDING_SIZE
  transposed_entries(entries, column_size: column_size).each do |row_entries|
    puts row_entries.map { |item| (item || '').ljust(column_width) }.join
  end
end

# ファイルリストを列ごとに分解する
def transposed_entries(entries, column_size: COLUMNS_SIZE)
  slice_size = (entries.size / column_size.to_f).ceil
  sliced_entries = entries.each_slice(slice_size)
  max_size = sliced_entries.map(&:size).max
  sliced_entries.map { |item| item.values_at(0...max_size) }.transpose
end

options = ARGV.getopts('a', 'r')
path = ARGV[0] || DEFAULT_PATH

execute(path, options: options)
