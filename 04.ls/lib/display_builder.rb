# frozen_string_literal: true

class DisplayBuilder
  attr_reader :column_widths

  def build_display(all_file_names, column:, show_hidden: false)
    directory_file_names = show_hidden ? all_file_names : reject_hidden_files(all_file_names)
    display_cells = Array.new(column) { Array.new((directory_file_names.size.to_f / column).ceil, nil) }
    filled_display_cells = fill_cells(display_cells, directory_file_names)
    format_display_cells(filled_display_cells)
  end

  def reject_hidden_files(all_file_names)
    all_file_names.reject { |file_name| file_name.start_with?('.') }
  end

  def fill_cells(display_cells, directory_file_names)
    file_index = 0
    display_cells.each_with_index do |cols, cells_index_row|
      cols.each_index do |cells_index_col|
        display_cells[cells_index_row][cells_index_col] = directory_file_names[file_index]
        file_index += 1
      end
    end
  end

  def format_display_cells(display_cells)
    @column_widths = display_cells.map(&:compact).map { |cell| cell.map(&:length) }.map(&:max)
    display_cells.transpose.map(&:compact)
  end
end
