#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ls_methods'
def main
  file_system_arr = get_all_file_system
  ls_without_any_options(file_system_arr)
end

main
