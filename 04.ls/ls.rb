# frozen_string_literal: true

require_relative 'ls_methods'
require 'optparse'

def main
  option = {}
  opt = OptionParser.new

  opt.on('-a') { |v| option[:a] = v }
  opt.parse!(ARGV)
  path = ARGV[0].nil? ? '.' : ARGV[0]
  contents = get_files(path)
  converted_contents = convert_with_option(contents, option)
  show_ls(converted_contents)
end

main
