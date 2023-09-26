# frozen_string_literal: true

require './file_item'
require './file_column_group'

class PluralFileColumnGroup < FileColumnGroup
  def initialize(filenames, longest_filename_length)
    files = create_file_items(filenames)
    super(files, longest_filename_length)
  end

  private

  def create_file_items(filenames)
  end

  def create_text(files, longest_filename_length)
    files.map { |file| file.name&.ljust(longest_filename_length + 1) }.join
  end
end
