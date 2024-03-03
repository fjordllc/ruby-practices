# frozen_string_literal: true

@col = 3
@files = Dir.glob('*').sort
@element_number = @files.size / @col
@remainder = @files.size % @col

def bytesize(array_element)
  array_element.encode('EUC-JP').bytesize
end

def slice(first, final, element_count)
  @files[first..final].each_slice(element_count).to_a
end

file_size_max = @files.map { |n| bytesize(n) }.max

if @files.size <= @col
  files_include_space = []
  @files.each do |n|
    files_include_space << "#{n}#{' ' * (file_size_max - bytesize(n))} "
  end
  puts files_include_space.join

else

  if @remainder != 0
    col_array_include_remainder = slice(0, (@element_number + 1) * @remainder - 1, @element_number + 1)
    col_array_without_remainder = slice((@element_number + 1) * @remainder, (@files.size - 1), @element_number)
    col_array = col_array_include_remainder + col_array_without_remainder
  else
    col_array = @files.each_slice(@element_number)
  end

  row_array = []
  m = 0
  while m < @element_number
    row_array_element = []
    col_array.each do |k|
      row_array_element << "#{k[m]}#{' ' * (file_size_max - bytesize(k[m]))} "
    end
    row_array << row_array_element
    m += 1
  end

  l = 0
  col_remainder_array_elements = []
  while l <= @remainder - 1
    col_remainder_array_elements << "#{col_array[l][@element_number]}#{' ' * (file_size_max - bytesize(col_array[l][@element_number]))} "
    l += 1
  end
  col_remainder_array_elements != [] && row_array << col_remainder_array_elements

  row_array.map { |array| puts array.map(&:to_s).join }

end
