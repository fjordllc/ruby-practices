# frozen_string_literal: true

require_relative 'game'
require_relative 'frame'
require_relative 'shot'

score_text = ARGV[0]
game = Game.new(score_text)
puts game.score
