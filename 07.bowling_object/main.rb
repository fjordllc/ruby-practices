require_relative 'game'
require_relative 'shot'

score_texts = ARGV[0]
game = Game.new(score_texts)
p game.score_texts
game.make_shot(score_texts)

