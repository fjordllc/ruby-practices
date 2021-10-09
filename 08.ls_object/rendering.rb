# frozen_string_literal: true

require 'io/console'

class Rendering
  COLUMN_NUMBER = 3

  def initialize(params, files)
    @width = IO.console.winsize[1]
    @params = params
    @files = files
  end

  def output
    @params['l'] ? render_long : render_short
  end

  private

  def render_short
    max_file_name_count = @files.map { |file| File.basename(file).size }.max
    ajusted_files = adjust_to_max_file_name_count(@files, max_file_name_count)
    max_column_count = COLUMN_NUMBER

    ajusted_files.each_slice(max_column_count).map do |file|
      puts file.join(' ')
    end
  end

  def adjust_to_max_file_name_count(files, max_file_name_count)
    files.map do |file|
      file.ljust(max_file_name_count)
    end
  end

  def render_long
    analysed_data = FileAnalyser.new(@files).analyse
    block_total = analysed_data.sum { |data| data[:blocks] }
    head = "total #{block_total}"
    body = make_long_format_body(analysed_data)
    puts [head, *body].join("\n")
  end

  def make_long_format_body(analysed_data)
    max_sizes = %i[nlink user group size mtime].map do |key|
      find_max_size(analysed_data, key)
    end
    analysed_data.map do |data|
      format_row(data, max_sizes)
    end
  end

  def find_max_size(analysed_data, key)
    analysed_data.map { |data| data[key].size }.max
  end

  def format_row(data, max_sizes)
    [
      data[:type_and_mode],
      "  #{data[:nlink].rjust(max_sizes[0])}",
      " #{data[:user].ljust(max_sizes[1])}",
      "  #{data[:group].ljust(max_sizes[2])}",
      "  #{data[:size].rjust(max_sizes[3])}",
      " #{data[:mtime].rjust(max_sizes[4])}",
      " #{data[:name]}"
    ].join
  end
end
