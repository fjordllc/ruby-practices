#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/game'

game = Game.new(ARGV[0])
puts game.score
