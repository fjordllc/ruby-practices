#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/game'

if __FILE__ == $PROGRAM_NAME # rubocop:disable Style/IfUnlessModifier
  puts Game.new(ARGV[0]).score
end
