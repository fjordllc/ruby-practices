#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ls_methods'
require 'optparse'

def main
  option = {}
  opt = OptionParser.new

  opt.on('-l') { |v| option[:l] = v }
  opt.parse!(ARGV)
  path = ARGV[0].nil? ? '.' : ARGV[0]
  files = files(path)
  transformed_files = transform_files_for_long_format(files, option, path)

  if option[:l]
    transformed_files.each { |files| puts files }
  else
    show_as_grid(transformed_files)
  end
end
main
