# frozen_string_literal: true

require_relative 'game'

def score_numbers_for_frame(score_texts)
  scores = score_texts.split(',')
  score_numbers = []
  scores.each do |score_text|
    if score_text == 'X'
      score_numbers << 10
      score_numbers << 0
    else
      score_numbers << score_text.to_i
    end
  end
  score_numbers
end

if __FILE__ == $PROGRAM_NAME
  score_texts = ARGV[0]
  score_numbers = score_numbers_for_frame(score_texts)
  game = Game.new(score_numbers)
  p game.sum_up
end
