# frozen_string_literal: true

require 'find'

def ls(dir, column)
  files = []
  Find.find(dir) do |file|
    file_name = File.basename(file)
    next if /^\./ =~ file_name || File.basename(dir) == file_name

    files << case File.ftype(file)
             when 'directory'
               "#{file_name}/"
             when 'link'
               "#{file_name}@"
             else
               file_name
             end
  end
  files_per_column = files.length / column + 1
  0.upto(files_per_column).each_with_index do |line_number, index|
    files.each_slice(files_per_column) do |file|
      columns = file.to_a
      print columns[line_number].ljust(17) if columns[line_number]
    end
    print "\n" unless index == files_per_column - 1
  end
end

current_dir = File.absolute_path('.')
ls(current_dir, 3)
