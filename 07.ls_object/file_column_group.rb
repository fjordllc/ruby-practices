# frozen_string_literal: true

class FileColumnGroup
  attr_reader :text

  def initialize(file_items, longest_filename_length = '')
    @text = create_text(file_items, longest_filename_length)
  end
end
