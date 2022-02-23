#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'io/console/size'
require 'pathname'

OUTPUT_MAX_COLUMNS = 3

module LsFilters
  class << self
    # 隠しファイル・ディレクトリ フィルタ
    def hide_hidden_entries
      ->(entry) { File.basename(entry) !~ /^\./ }
    end
    # 将来フィルタを追加していく
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
  # 将来オプションを実装する
  argv = opt.parse(ARGV)

  # オプションに応じた出力フィルタ追加
  filters = [LsFilters.hide_hidden_entries]

  ls = Ls.new(filters)

  argv = ['./'] if argv.count.zero?
  ls.entries = argv
  ls.output
end

class Ls
  attr_writer :entries, :filters

  def initialize(filters = [LsFilters.hide_hidden_entries])
    @filters = filters
    @entries = []
  end

  def output
    exclude_entries_nonexistent
    files = @entries.select { |entry| File.file?(entry) }
    dirs = @entries.select { |entry| File.directory?(entry) }

    # 実際のlsではファイルの出力が優先
    output_files(files)
    puts "\n" unless files.size.zero? || dirs.size.zero?
    if files.size.zero?
      output_dirs(dirs, force_label: (dirs.size != 1))
    else
      output_dirs(dirs, force_label: true)
    end
  end

  def exclude_entries_nonexistent
    @entries.select! do |entry|
      return true if File.exist?(entry)

      puts "ls: #{entry}: No such file or directory"
      false
    end
  end

  private

  def output_files(files)
    return if files.size.zero?

    file_entries = apply_filters(files)
    formatted = create_formatted_list(format_entries(file_entries.sort))

    max_rows = formatted.size.zero? ? 0 : formatted[0].size
    output_common(formatted, max_rows)
  end

  def output_dirs(dirs, force_label: false)
    force_label = true if dirs.size > 1

    dirs.each_with_index do |dir, index|
      entries_in_dir = apply_filters(Dir.entries(dir))

      puts "\n" if index.positive?
      puts "#{dir}:" if force_label
      next if entries_in_dir.size.zero?

      formatted = create_formatted_list(format_entries(entries_in_dir.sort))
      max_rows = formatted[0].size

      output_common(formatted, max_rows)
    end
  end

  def output_common(entry_list, num_of_rows)
    (0..num_of_rows - 1).each do |n|
      row = []
      entry_list.each do |column|
        row << column[n] unless column[n].nil?
      end

      puts row.join(' ').rstrip if row.count.positive?
    end
  end

  def apply_filters(entries)
    @filters.each do |filter|
      entries.select! { |e| filter.call(e) }
    end
    entries
  end

  def format_entries(entries)
    max_word_width = entries.map(&:space_size).max

    entries.map do |entry|
      num_of_chars = entry.size
      # 右に埋めるべき空白数
      spaces_of_completement = max_word_width - entry.space_size
      format("%-#{num_of_chars + spaces_of_completement}s", entry)
    end
  end

  def create_formatted_list(entries)
    return entries if entries.size.zero?

    num_of_columns = calc_num_of_columns(entries[0].space_size)
    format_list(entries, num_of_columns)
  end

  def calc_num_of_columns(word_length)
    num_of_columns = OUTPUT_MAX_COLUMNS
    console_width = IO.console_size[1]
    # コンソールウインドウの幅に応じて列幅を調節する
    (1..OUTPUT_MAX_COLUMNS).to_a.reverse_each do |n|
      if n * word_length <= console_width
        num_of_columns = n
        break
      end
    end
    num_of_columns
  end

  def format_list(entries, num_of_columns)
    columns = (1..num_of_columns).map { [] }
    max_rows = entries.size / num_of_columns
    max_rows += (entries.size % num_of_columns).positive? ? 1 : 0

    entries.each_with_index do |entry, index|
      column_index = index / max_rows
      if index != 0 && index == entries.size - 1 && columns[num_of_columns - 1].size.zero?
        columns[num_of_columns - 1].push entry
      else
        columns[column_index].push entry
      end
    end
    columns
  end
end

main if __FILE__ == $PROGRAM_NAME
