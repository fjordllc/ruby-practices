#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

game = Game.new(ARGV[0])
puts game.calc_scores
