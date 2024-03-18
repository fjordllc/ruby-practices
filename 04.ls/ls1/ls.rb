# frozen_string_literal: true

COL = 3
@files = Dir.glob('*').sort
element_number = @files.size / COL
remainder = @files.size % COL

def bytesize(array_element)
  array_element.encode('EUC-JP').bytesize
end

def slice(first, final, element_count)
  @files[first..final].each_slice(element_count).to_a
end

file_size_max = @files.map { |file| bytesize(file) }.max

if @files.size <= COL
  files_include_space = @files.map { |file| "#{file}#{' ' * (file_size_max - bytesize(file))} " }
  puts files_include_space.join

else
  if remainder != 0
    col_array_include_remainder = slice(0, ((element_number + 1) * (@files.size / (element_number + 1))) - 1, element_number + 1)
    col_array_without_remainder = slice(((element_number + 1) * (@files.size / (element_number + 1))), -1, element_number + 1)
    col_array = col_array_include_remainder + col_array_without_remainder
    row_array = Array.new((element_number + 1)) do |m|
      col_array.map { |k| k[m] }.compact.map { |p| "#{p}#{' ' * (file_size_max - bytesize(p))} " }
    end
  else
    col_array = @files.each_slice(element_number)
    row_array = Array.new(element_number) do |m|
      col_array.map { |k| "#{k[m]}#{' ' * (file_size_max - bytesize(k[m]))} " }
    end
  end

  row_array.map { |array| puts array.map(&:to_s).join }

end
