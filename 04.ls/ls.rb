#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ls_methods'
require 'optparse'

def main
  option = {}
  opt = OptionParser.new

  opt.on('-a') { |v| option[:a] = v }
  opt.parse!(ARGV)

  contents = get_files(ARGV[0])
  convert_with_option!(contents, option)
  show_ls(contents)
end

main
