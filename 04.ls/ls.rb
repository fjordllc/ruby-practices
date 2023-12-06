#! /usr/bin/env ruby
# frozen_string_literal: true

input = ARGV[0]&.to_s || '.'
Dir.entries(input).reject { |file| /^\..*/.match(file) }.sort.map { |file| print "#{file}\s\s" }
print "\n"
