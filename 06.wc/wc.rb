#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def directory_or_file(name)
  if Dir.exist?(name)
    if name.end_with?('/')
      name
    else
      "#{name}/"
    end
  elsif name.end_with?('/')
    puts "wc: #{name}: Not a directory"
    nil
  elsif File.exist?(name)
    name
  else
    puts "wc: #{name}: No such file or directory"
    nil
  end
end

opt = OptionParser.new

params = {}

opt.on('-l') { |v| params[:l] = v }

opt.parse!(ARGV)

pattern = if ARGV.empty?
            '*'
            # TODO: basic input in wc?
          else
            ARGV
              .map { |arg| directory_or_file(arg) }
              .compact
              .map { |file| "#{file}*" }
          end

files = Dir.glob(pattern).sort

files.each do |f|
  file = File.new(f)
  line_num = file.each_line.count # lines

  file = File.new(f)
  word_num = file.each_line.reduce { |result, s| result << s }.split(' ').count # words

  byte_num = file.size # byte

  p line_num, word_num, byte_num
end
