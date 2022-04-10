# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative 'file_extractor'
require_relative 'file_info_collector'
require_relative 'file_info_formatter'
require_relative 'file_display_formatter'
require_relative 'command'

options = ARGV.getopts('a', 'r', 'l')
collected_files = FileInfoCollector.new(options).build_file_details
formatted_files = FileDisplayFormatter.new(options, collected_files).build_formatted_files
Command.new(options, formatted_files).ls
