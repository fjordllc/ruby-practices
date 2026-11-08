#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './lib/display_builder'
require_relative './lib/display_options'
require 'optparse'

opt = OptionParser.new

options = {}
opt.on('-a') { options[:show_hidden] = true }
opt.on('-r') { options[:dir_reverse] = true }

opt.parse!(ARGV)

myls_options = DisplayOptions.new(**options)

builder = DisplayBuilder.new
all_file_names = myls_options.options[:dir_reverse] ? Dir.entries('.').sort.reverse : Dir.entries('.').sort
builder.build_display(
  all_file_names,
  column: myls_options.options[:column],
  show_hidden: myls_options.options[:show_hidden]
).each do |file_name|
  puts file_name.map.with_index { |file, index| file.ljust(builder.column_widths[index]) }.join(' ')
end
