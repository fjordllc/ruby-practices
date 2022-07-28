# frozen_string_literal: true
require 'optparse'
opt = OptionParser.new
args = {}
opt.on('-a') {|v| args[:a] = v}
opt.parse!(ARGV)

def input(args)
a = args[:a].nil? ? 0 : File::FNM_DOTMATCH
unless args[:a].nil?
  a = File::FNM_DOTMATCH
end
Dir.glob("*",a)
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

arr = input(args)
output(arr)
