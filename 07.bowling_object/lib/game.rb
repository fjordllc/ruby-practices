require_relative 'frame'
require 'debug'

class Game
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def split_score
    @scores.split(',')
  end

  def game_scores
    scores = []
    frames = []

    split_score.each do |score|
      scores << score
      scores << '0' if scores.size < 18 && score == 'X'
    end

    scores.each_slice(2) { |score| frames.size == 10 ? frames[9] << score[-1] : frames << score }
    frames = frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }
    Game.new(frames)
  end

  def calc_scores
    frames = game_scores.scores
    frames.each_with_index.sum do |frame, index|
      if frame.first_shot.score == 10
        if index < 8 && frames[index + 1].first_shot.score == 10
          frame.sum_shots + frames[index + 1].first_shot.score + frames[index + 2].first_shot.score
        elsif index == 9
          frame.sum_shots
        else
          frame.sum_shots + frames[index + 1].first_shot.score + frames[index + 1].second_shot.score
        end
      elsif frame.sum_shots == 10 && index < 9
        frame.sum_shots + frames[index + 1].first_shot.score
      else
        frame.sum_shots
      end
    end
  end

end
