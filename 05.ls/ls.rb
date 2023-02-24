# frozen_string_literal: true

def files
  Dir.glob('*').map do |list|
    list
  end
end

frame = []
files.each_slice(4) do |s|
  frame << s
end

def display(file_lists)
  file_lists.each do |index|
    index.each do |item|
      print item.to_s.ljust(10)
    end
    puts "\n"
  end
end
display(frame.transpose)
