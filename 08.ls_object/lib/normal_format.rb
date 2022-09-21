
require_relative 'file'

module Ls
  class NormalFormat
    MAXIMUM_COLUMN = 3
    FILENAME_MARGIN = 4

    def initialize
      @files = File.generate_file
    end

    def lines
      total_files = @files.size
      lines = (total_files.to_f / MAXIMUM_COLUMN).ceil(0)
    end

    def sliced_files
      files = []
      @files.each_slice(lines) { |n| files << n }
      if @files.size >= MAXIMUM_COLUMN && @files.size % MAXIMUM_COLUMN != 0
        (MAXIMUM_COLUMN - @files.size % MAXIMUM_COLUMN).to_i.times { files.last << nil }
      end
      files
    end

    def sorted_files
      sliced_files.transpose
    end

    def show_files
      longest_filename = @files.max_by { |file| file.filename.size }.filename
      sorted_files.each do |sorted_file|
        sorted_file.each do |s|
          next if s.nil?
          print s.filename.ljust(longest_filename.size + FILENAME_MARGIN)
        end
        puts
      end
    end
  end
end
