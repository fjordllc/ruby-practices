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

opt = OptionParser.new
options = {}
opt.on('-a', '全部のファイル表示') { |v| options[:a] = v }
opt.parse(ARGV)

files = Dir.glob('*', options[:a] ? File::FNM_DOTMATCH : 0)

ls(3, files)
