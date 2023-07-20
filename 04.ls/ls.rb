#!/usr/bin/env ruby
# frozen_string_literal: true

target_path = ARGV[0] ||= "./"

def get_filenames (target_path)
  Dir.entries(target_path).sort
end

def output (filenames)
  filenames.each do |filename|
    puts filename
  end
end

filenames = get_filenames(target_path)
output(filenames)
