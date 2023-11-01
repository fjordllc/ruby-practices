# frozen_string_literal: true

def main(row, path)
  @row = row
  find_files(path)
  format_files(@files)
  sort_files(@formatted_files)
  display_files
end

def set_paramater
  path = '*'
  option = OptionParser.new
  option.on('-a') { path = '{.,*}{.,*}' }
  option.parse!(ARGV)
  path
end

def find_files(path)
  files = Dir.glob(path)
  @files = files
end

def format_files(files)
  most_long_name = files.max_by(&:length)
  @formatted_files = files.map { |file| file.ljust(most_long_name.length + 4) }
end

def sort_files(formatted_files)
  @sorted_files = formatted_files.sort
  @vertical_lines = []
  number_of_lines = (@sorted_files.length.to_f / @row).ceil
  number_of_lines.times do |col|
    @row.times do |row|
      @vertical_lines << @sorted_files[col + number_of_lines * row]
    end
  end
end

def display_files
  @vertical_lines.each_with_index { |file, index| print ((index + 1) % @row).zero? ? "#{file}\n" : file }
end

main(3)
