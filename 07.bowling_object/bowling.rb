# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'
require_relative 'game'

game = Game.new(ARGV[0])
p game.total_score
