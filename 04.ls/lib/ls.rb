#!/usr/bin/env ruby
# frozen_string_literal: true

def get_file_list()
  Dir.glob('*')
end

puts get_file_list
