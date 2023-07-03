# frozen_string_literal: true

require 'optparse'
require_relative 'long_format_outputter'
require_relative 'normal_format_outputter'

options = ARGV.getopts('a', 'r', 'l')
file_names = Dir.glob('*', options['a'] ? File::FNM_DOTMATCH : 0)
file_names = file_names.reverse if options['r']
options['l'] ? LongFormatOutputter.new(file_names).output : NormalFormatOutputter.new(file_names).output
