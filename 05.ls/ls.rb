#!/usr/bin/env ruby
# frozen_string_literal: true

DEFAULT_PATH = ".."
COLUMNS_SIZE = 3
PADDING_SIZE = 1

def execute(base_path: DEFAULT_PATH)
  entries = find_entries(base_path)
  display_entries(entries)
end

def find_entries(base_path)
  Dir.glob('*', base: base_path)
end

def display_entries(entries = [], column_size: COLUMNS_SIZE)
  sliced_entries = entries.each_slice(column_size)
  max_size = sliced_entries.map(&:size).max
  max_entry_name_size = entries.map(&:size).max
  transposed = sliced_entries.map{|item| item.values_at(0...max_size)}.transpose
  transposed.each do |row|
    puts row.map{|item| (item || "").ljust(max_entry_name_size + PADDING_SIZE)}.join
  end
end

execute
