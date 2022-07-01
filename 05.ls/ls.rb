require "find"

def ls(dir, column)
  files = []
  Find.find(dir) do |file|
    file_name = File.basename(file)
    unless /^\./ =~ file_name || File.basename(dir) == file_name
      case File.ftype(file)
      when "directory"
        files << file_name + '/'
      when "link"
        files << file_name + '@'
      else
        files << file_name
      end
    end
  end
  files_per_column = files.length / column + 1
  0.upto(files_per_column).each_with_index do |line_number, index|
    files.each_slice( files_per_column ) do |file|
      columns = file.to_a
      print columns[line_number].ljust(17) if columns[line_number]
    end
    print "\n" unless index == files_per_column - 1
  end
end

current_dir = File.absolute_path('.')
ls(current_dir, 3)
