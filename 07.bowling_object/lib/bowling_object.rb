#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

if __FILE__ == $PROGRAM_NAME
  game = Game.new(ARGV[0])
  puts game.calc_scores
end
