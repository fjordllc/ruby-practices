# frozen_string_literal: true

require_relative 'game'

score_texts = ARGV[0]
# 引数の加工をここでやってしまった。
def score_numbers_for_frame(score_texts)
  scores = score_texts.split(',')
  score_numbers = []
  scores.each do |score|
    if score == 'X'
      score_numbers << 10
      score_numbers << 0
    else
      score_numbers << score.to_i
    end
  end
  score_numbers
end

score_numbers = score_numbers_for_frame(score_texts)
game = Game.new(score_numbers)
p game.total_score

