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
  contents = get_files(path)
  converted_contents = convert_with_option!(contents, option, path)

  if option[:l]
    converted_contents.each { |content| puts content }
  else
    show_ls(converted_contents)
  end
end
main
