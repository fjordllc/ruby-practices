require_relative 'frame'

class Game
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def split_scores
    scores = []
    split_score = @scores.split(',')
    split_score.each do |score|
      scores << score
      scores << '0' if scores.size < 18 && score == 'X'
    end
    scores
  end

  def game_scores
    frames = []
    split_scores.each_slice(2) { |score| frames.size == 10 ? frames[9] << score[-1] : frames << score }
    frames = frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }
    Game.new(frames)
  end

  def calc_scores
    frames = game_scores.scores
    frames.each_with_index.sum do |frame, index|
      if frame.strike? && index <= 8
        if frames[index + 1].strike? && index < 8
          frame.sum_shots + frames[index + 1].first_shot.score + frames[index + 2].first_shot.score
        else
          frame.sum_shots + frames[index + 1].first_shot.score + frames[index + 1].second_shot.score
        end
      elsif frame.spare? && index < 9
        frame.sum_shots + frames[index + 1].first_shot.score
      else
        frame.sum_shots
      end
    end
  end

end
