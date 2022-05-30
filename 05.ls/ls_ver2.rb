require 'optparse'
require 'debug'

def main
  get_deta
  make_array
  show_files
end

def get_deta
  Dir.glob("*").sort
end

MAX_ROW = 3.0
def make_array
  current_dir = get_deta
  total_file_size = current_dir.size
  columns = (total_file_size / MAX_ROW).ceil
  arrays = []
  if total_file_size.zero?
    arrays
  else
    current_dir.each_slice(columns) do |list_of_file|
      arrays << list_of_file
    end
    max_size = arrays.map(&:size).max
    arrays.map! { |element| element.values_at(0...max_size) }
  end
end

def show_files
  transposed_array = make_array.transpose
  transposed_array.each do |two_dimensional_array|
    two_dimensional_array.each do |file|
      print "#{file}".ljust(25)
    end
    print  "\n"
  end
end

main
