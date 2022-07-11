# frozen_string_literal: true

class FileList
  NUMBER_OF_COLUMNS = 3

  def initialize(dir)
    @dir = dir
  end

  def output_file_list
    array_containing_multiple_arrays = Array.new(NUMBER_OF_COLUMNS) { [] }
    number_of_files_per_column = Rational(@dir.size, NUMBER_OF_COLUMNS).ceil
    index = 0
    @dir.each do |file|
      array_containing_multiple_arrays[index] << file.file_name
      index += 1 if (array_containing_multiple_arrays[index].size % number_of_files_per_column).zero?
    end
    array_with_interchanged_rows_and_columns_of_multiple_arrays = array_containing_multiple_arrays.map do |arr|
      arr.values_at(0...number_of_files_per_column)
    end.transpose
    maximum_number_of_words = @dir.map { |file| file.file_name.size }.max
    array_with_interchanged_rows_and_columns_of_multiple_arrays.each do |arr|
      arr.each do |file|
        print file.to_s.ljust(maximum_number_of_words + 7)
      end
      puts
    end
  end
end
