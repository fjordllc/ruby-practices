require_relative './game'

game = Game.new(ARGV[0])

p game.total_score
