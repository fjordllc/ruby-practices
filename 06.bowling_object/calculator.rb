#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

shots = ARGV[0].split(',').map { |s| s == 'X' ? 10 : s.to_i }
game = Game.new
shots.each { |pins| game.add_shot(pins) }
puts game.score
