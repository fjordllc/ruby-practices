require_relative 'game'
require_relative 'shot'
require_relative 'frame'


score_texts = ARGV[0]
game = Game.new(score_texts)
p game.score_texts
p game.make_frames(score_texts)



