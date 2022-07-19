# frozen_string_literal: true

def input()
  arr = []
  Dir.glob('*').to_a.each do |d|
    arr
  end
end

def output(arr)
  arrsize = arr.size / 3
  (0..arrsize).each do |i|
    3.times {|a|
    print "#{arr[i+a]} ".ljust(25)
    a += arrsize
    i += 4
  }
  puts "\n"
  end
end

arr = input
output(arr)
