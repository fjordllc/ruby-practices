# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(scores)
    @frames = Frame.generate_frames(scores)
  end

  def calc_scores
    @frames.each_with_index.sum do |frame, index|
      if frame.strike? && index < 9
        frame.sum_shots + strike_bonus(@frames, index)
      elsif frame.spare? && index < 9
        frame.sum_shots + spare_bonus(@frames, index)
      else
        frame.sum_shots
      end
    end
  end

  private

  def split_scores
    split_scores = []
    @scores.split(',').each do |score|
      split_scores << score
      split_scores << '0' if split_scores.size < 18 && score == 'X'
    end
    split_scores
  end

  def strike_bonus(frames, index)
    if next_frame(frames, index).strike? && index < 8
      next_frame(frames, index).first_shot.score + next_next_frame(frames, index).first_shot.score
    else
      next_frame(frames, index).first_shot.score + next_frame(frames, index).second_shot.score
    end
  end

  def spare_bonus(frames, index)
    next_frame(frames, index).first_shot.score
  end

  def next_frame(frames, index)
    frames[index + 1]
  end

  def next_next_frame(frames, index)
    frames[index + 2]
  end
end
