# frozen_string_literal: true

class Column
  attr_accessor :max_name_size, :files

  def initialize
    @files = []
    @max_name_size = 0
  end

  def add(file)
    size = file.size
    @files << file
    @max_name_size = size if @max_name_size < size
  end

  def show(index)
    @files[index] ? @files[index].ljust(@max_name_size) : nil
  end
end
