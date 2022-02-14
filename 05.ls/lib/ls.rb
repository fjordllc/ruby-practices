#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'debug'

OUTPUT_MAX_ROWS = 4

module EntryFilters
  class << self
    # 隠しファイルフィルタ
    def hidden_files
      ->(entry) { entry !~ /^\./ }
    end
    # フィルタを追加していく
  end
end

def output(file_name, filters)
  entries = Dir.entries(file_name)
  filters.each do |filter|
    entries.filter! { |e| filter.call(e) }
  end
  form(entries.sort)
end

def form(entries)
  rows = (1..OUTPUT_MAX_ROWS).map { [] }
  entries.each_with_index do |entry, index|
    rows[index % OUTPUT_MAX_ROWS].push entry
  end

  rows.each do |row|
    if row.count == 1
      puts row[0] unless row[0].nil?
    else
      puts row.join("\t")
    end
  end
end

opt = OptionParser.new
# 将来オプションを実装する
argv = opt.parse(ARGV)

filters = []
filters << EntryFilters.hidden_files

argv.each do |arg|
  raise "ファイルまたはディレクトリが見つかりません: #{arg}" unless File.exist?(arg)

  output(arg, filters)
end
