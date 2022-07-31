# frozen_string_literal: true
require 'optparse'
opt = OptionParser.new
args = {}
opt.on('-r') {|v| args[:r] = v}
opt.parse!(ARGV)

def input(args)
  Dir.glob("*")
end

def output(arr,args)
  r = args[:r].nil? ? 0 : arr.reverse!
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

arr = input(args)
output(arr,args)
