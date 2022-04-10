# frozen_string_literal: true

class FileDisplayFormatter
  COLUMN_COUNT = 3.0

  attr_reader :l_option, :files

  def initialize(options, files)
    @l_option = options['l']
    @files = files
  end

  def build_formatted_files
    if l_option
      format_with_l_option
    else
      format_without_l_option
    end
  end

  private

  def format_without_l_option
    file_count_per_column = calc_file_count_per_column(files)
    transposed_files = []
    file_details.each do |column|
      max_str_count = column.max_by(&:size).size
      transposed_files << column.map { |v| v.ljust(max_str_count + 2) }
    end

    last_column = transposed_files.last
    (file_count_per_column - last_column.size).times { last_column << '' }

    transposed_files.transpose
  end

  def format_with_l_option
    formatted_file_details = []
    file_details.transpose.each.with_index do |data_list, index|
      max_str_count = data_list.max_by(&:size).size
      # ファイルサイズや日付などを右詰にしグループ名などを左詰するための処理
      formatted_file_details <<
        case index
        when file_details.transpose.length - 1
          data_list.map { |v| v }
        when 1, 4, 5
          data_list.map { |v| v.rjust(max_str_count) }
        else
          data_list.map { |v| v.ljust(max_str_count) }
        end
    end
    formatted_file_details.transpose
  end

  def file_details
    target_files = files.map { |file| file['file_name'] }
    if l_option
      divided_files = files.map { |file| [file['mode'], file['nlink'], file['uid'], file['gid'], file['size'], file['date'], file['file_name']] }
    else
      file_count_per_column = calc_file_count_per_column(files)
      divided_files = target_files.each_slice(file_count_per_column).to_a
    end
    divided_files
  end

  def calc_file_count_per_column(files)
    (files.size / COLUMN_COUNT).ceil
  end
end
