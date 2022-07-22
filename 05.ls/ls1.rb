# frozen_string_literal: true

def input()
  Dir.glob('*')
end

def output(arr)
  files = ((arr.size + 1).to_f / 3).ceil
  files.times do |row|
    col = 0
    3.times do
      print "#{arr[row+col]} ".ljust(25)
      col += files
    end
  puts "\n"
  end
end

arr = input
output(arr)
