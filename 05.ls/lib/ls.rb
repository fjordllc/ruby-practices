#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'io/console/size'
require 'debug'

OUTPUT_MAX_COLUMNS = 3

class Ls
  attr_writer :entry_name, :filters

  def initialize(filters = [LsFilters.hide_hidden_files])
    @filters = filters
  end

  def output
    raise "ファイルまたはディレクトリが見つかりません: #{@entry_name}" unless File.exist?(@entry_name)

    entries = Dir.entries(@entry_name)
    # 出力フィルタの適用
    @filters.each do |filter|
      entries.filter! { |e| filter.call(e) }
    end

    formatted = create_list_data(format_entries(entries.sort))
    return if formatted.size.zero?

    max_rows = formatted[0].size

    (0..max_rows - 1).each do |n|
      row = []
      formatted.each do |column|
        row << column[n] unless column[n].nil?
      end

      puts row.join(' ').rstrip if row.count.positive?
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
      string_width = entry.space_size
      num_of_chars = entry.size
      # 右に埋めるべき空白数
      spaces_of_completement = max_width - string_width
      format("%-#{num_of_chars + spaces_of_completement}s", entry)
    end
  end

  def console_width
    IO.console_size[1]
  end

  def create_list_data(entries)
    return entries if entries.size.zero?

    string_width = entries[0].space_size
    num_of_columns = OUTPUT_MAX_COLUMNS

    # コンソールウインドウの幅に応じて列幅を調節する
    (1..OUTPUT_MAX_COLUMNS).to_a.reverse_each do |n|
      if n * string_width <= console_width
        num_of_columns = n
        break
      end
    end

    columns = (1..num_of_columns).map { [] }
    max_rows = entries.size / num_of_columns
    max_rows += (entries.size % num_of_columns).positive? ? 1 : 0

    entries.each_with_index do |entry, index|
      column_index = index / max_rows
      columns[column_index].push entry
    end
    columns
  end
end

class String
  # 空白に換算したときの文字幅を計算する
  def space_size
    chars.map { |c| c.ascii_only? ? 1 : 2 }.sum
  end
end

# main
def main
  opt = OptionParser.new
  # オプションを実装する（予定）
  argv = opt.parse(ARGV)

  # オプションに応じた出力フィルタ追加（予定）
  filters = [LsFilters.hide_hidden_files]

  ls = Ls.new(filters)

  argv = ['./'] if argv.count.zero?
  argv.each do |arg|
    ls.entry_name = arg
    ls.output
  end
end

module LsFilters
  class << self
    # 隠しファイルフィルタ
    def hide_hidden_files
      ->(entry) { entry !~ /^\./ }
    end
    # フィルタを追加していく
  end
end

main
