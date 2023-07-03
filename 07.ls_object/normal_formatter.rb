# frozen_string_literal: true

class NormalFormatter
  attr_reader :file_names

  COLUMNS = 3

  def initialize(file_names)
    @file_names = file_names
  end

  def regular_format
    total_number = file_names.size
    slice = total_number / COLUMNS
    slice += 1 unless (total_number % COLUMNS).zero?
    names_slice = file_names.each_slice(slice).to_a
    names_slice[0].zip(*names_slice[1..])
  end
end
