#!ruby
# frozen_string_literal: true

require_relative 'ls_methods'
def main
  p LsMethods.new.ls_without_any_options
end

main
