# frozen_string_literal: true

require 'optparse'
MAX_COLUMNS = 3
MARGIN_WIDTH = 2

def parse_options
  options = {}
  opt = OptionParser.new
  opt.on('-a') { |v| options[:a] = v }
  opt.parse!(ARGV)
  options
end

def fetch_files(options)
  if options[:a]
    Dir.entries('.')
  else
    Dir.glob('*')
  end
end

def format_in_columns(files, max_columns = MAX_COLUMNS)
  return '' if files.empty?

  row_count = files.size.fdiv(max_columns).ceil
  columns = files.each_slice(row_count).map { |slice| slice.values_at(0...row_count) }
  col_widths = columns.map { |col| col.compact.map(&:size).max }
  rows = columns.transpose

  rows.map { |row| format_row(row, col_widths) }.join("\n")
end

def format_row(row, col_widths)
  row.map.with_index do |file, col_idx|
    file&.to_s&.ljust(col_widths[col_idx] + MARGIN_WIDTH)
  end.join.rstrip
end

def main
  options = parse_options
  files = fetch_files(options).sort
  puts format_in_columns(files)
end

main if __FILE__ == $PROGRAM_NAME
