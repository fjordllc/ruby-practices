# frozen_string_literal: true

require './game'

game = Game.new(ARGV[0])
puts game.calculate_score
