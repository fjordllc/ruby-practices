# frozen_string_literal: true

require './07.bowling_object/shot'
require './07.bowling_object/frame'
require './07.bowling_object/game'

game = Game.new(ARGV.first)
puts game.result
