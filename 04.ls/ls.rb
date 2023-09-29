#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ls_methods'

def main
  args = { 'option' => nil, 'path' => '.' }

  ARGV.each do |arg|
    if arg.start_with?('-')
      args['option'] = arg[1..-1]
    else
      args['path'] = arg
    end
  end

  contents = get_files(args['path'])
  ls_with_options(contents, args['option'])
end

main
