#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ls_methods'
def main
  LsMethods.new.ls_without_any_options
end

main
