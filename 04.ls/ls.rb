#!/usr/bin/env ruby
require 'optparse'

def calculation_row(column, files)
  files.count.ceildiv(column)
end

def ls(column, files)
  row = calculation_row(column, files)
  row.times do |r|
    (0...column).each { |c| print files[r + row * c]&.ljust(40) }
    puts
  end
end

files = Dir.glob('*')

opt = OptionParser.new

opt.on('-a', '全てのファイルを参照') { files = Dir.glob('*', File::FNM_DOTMATCH).sort }
opt.parse!(ARGV)

ls(3, files)
