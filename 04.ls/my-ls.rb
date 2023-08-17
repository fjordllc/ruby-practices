#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.on("-l", "--list-details") do
    options[:details] = true
  end
end.parse!

if options[:details]
  list_entities_in_details(Dir.glob('*'))
else
  list_entities(Dir.glob('*'))
end
