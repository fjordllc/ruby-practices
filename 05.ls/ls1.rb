# frozen_string_literal: true

def input()
  Dir.glob('*')
end

def output(arr)
  arrseparate = Float(arr.size + 1) / 3
  arrseparate.round.times do |row|
    col = 0
    3.times do
      print "#{arr[row+col]} ".ljust(25)
      col += arrseparate.round
    end
  puts "\n"
  end
end

arr = input
output(arr)

