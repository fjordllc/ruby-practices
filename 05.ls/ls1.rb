# frozen_string_literal: true

def input()
  Dir.glob('*')
end

def output(arr)
  arrsize = (arr.size + 1).to_f / 3
  (1..arrsize.round).each do |row|
    col = 0
    3.times do
      print "#{arr[row+col-1]} ".ljust(25)
      col += arrsize.round
    end
  puts "\n"
  end
end

arr = input
output(arr)
