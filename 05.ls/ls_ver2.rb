require 'optparse'
require 'debug'

def main
  current_dir = Dir.glob("*").sort
  make_array(current_dir)
end

def make_array(current_dir)
  max_row = 3.0
  total_file_size = current_dir.size
  columns = (total_file_size / max_row).ceil
  if total_file_size >= 0
    arrays = []
    current_dir.each_slice(columns) do |list_of_file|
      arrays << list_of_file
    end
    max_size = arrays.map(&:size).max
    arrays.map! { |element| element.values_at(0...max_size) }
  else
    arrays = []
  end
  show_files(arrays)
end

def show_files(arrays)
  transposed_array = arrays.transpose
  transposed_array.each do |two_dimensional_array|
    two_dimensional_array.each do |file|
      print "#{file}".ljust(25)
    end
    print  "\n"
  end
end

main
