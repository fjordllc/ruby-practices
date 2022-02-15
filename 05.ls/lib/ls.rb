#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

OUTPUT_MAX_ROWS = 4

module LsFilters
  class << self
    # 隠しファイルフィルタ
    def hidden_files
      ->(entry) { entry !~ /^\./ }
    end
    # フィルタを追加していく
  end
end

class Ls
  attr_writer :entry, :filters

  def initialize(entry, filters = [LsFilters.hidden_files])
    @entry_name = entry
    @filters = filters
  end

  def output
    entries = Dir.entries(@entry_name)

    # 出力フィルタの適用
    @filters.each do |filter|
      entries.filter! { |e| filter.call(e) }
    end

    formatted = format(entries.sort)

    (0..OUTPUT_MAX_ROWS - 1).each do |n|
      row = []
      formatted.each do |column|
        row << column[n] unless column[n].nil?
      end
      puts row.join(' ') if row.count.positive?
    end
    0 # return code(success)
  end

  private

  def format(entries)
    columns = (1..(entries.count / OUTPUT_MAX_ROWS + 1)).map { [] }
    entries.each_with_index do |entry, index|
      column_index = index / OUTPUT_MAX_ROWS
      columns[column_index].push entry
    end

    # 出力する列の最大文字幅を計算して返す
    columns.map do |column|
      max_width = column.map do |element|
        element.chars.map { |char| char.ascii_only? ? 1 : 2 }.sum
      end.max
      column.map { |element| element.ljust(max_width) }
    end
  end
end

# main
if __FILE__ == $PROGRAM_NAME
  opt = OptionParser.new
  # オプションを実装する（予定）
  argv = opt.parse(ARGV)

  # オプションに応じた出力フィルタ追加（予定）
  filters = []
  filters << LsFilters.hidden_files

  argv.each do |arg|
    ls = Ls.new(arg, filters)
    raise "ファイルまたはディレクトリが見つかりません: #{arg}" unless File.exist?(arg)

    ls.output
  end
end
