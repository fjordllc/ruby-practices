#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'debug'

OUTPUT_MAX_COLUMNS = 3

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

    formatted = create_list_data(format_entries(entries.sort))
    max_rows = formatted[0].size

    (0..max_rows - 1).each do |n|
      row = []
      formatted.each do |column|
        row << column[n] unless column[n].nil?
      end

      puts row.join(" ").rstrip if row.count.positive?
    end
    0 # return code(success)
  end

  private

  def format_entries(entries)
    max_width = entries.map do |entry|
      entry.chars.map { |c| c.ascii_only? ? 1 : 2 }.sum
    end.max

    entries.map do |entry|
      # 半角スペースに換算した時の文字数
      string_width = entry.chars.map { |c| c.ascii_only? ? 1 : 2 }.sum
      real_width = entry.size
      # 右に埋めるべき空白数
      supplement_spaces = max_width - string_width
      format("%-#{real_width + supplement_spaces}s", entry)
    end
  end

  def create_list_data(entries)
    # コンソールウインドウの幅に応じて列幅を調節する
    columns = (1..OUTPUT_MAX_COLUMNS).map { [] }
    max_rows = entries.size / OUTPUT_MAX_COLUMNS
    max_rows += (entries.size % OUTPUT_MAX_COLUMNS).positive? ? 1 : 0
    entries.each_with_index do |entry, index|
      column_index = index / max_rows
      columns[column_index].push entry
    end
    columns
  end
end

# main
def main
  opt = OptionParser.new
  # オプションを実装する（予定）
  argv = opt.parse(ARGV)

  # オプションに応じた出力フィルタ追加（予定）
  filters = []
  filters << LsFilters.hidden_files

  argv = ['./'] if argv.count.zero?
  argv.each do |arg|
    ls = Ls.new(arg, filters)
    raise "ファイルまたはディレクトリが見つかりません: #{arg}" unless File.exist?(arg)

    ls.output
  end
end

main
