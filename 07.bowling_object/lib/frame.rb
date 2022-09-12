# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(index, first_mark, second_mark = nil, third_mark = nil)
    @index = index
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def self.generate_frames(scores)
    split_scores = []
    frames = []
    scores.split(',').each do |score|
      split_scores << score
      split_scores << '0' if split_scores.size < 18 && score == 'X'
    end
    split_scores.each_slice(2) { |score| frames.size == 10 ? frames[9] << score[-1] : frames << score }
    frames.map.with_index { |frame, index| Frame.new(index, frame[0], frame[1], frame[2]) }
  end

  def score(frames)
    if strike? && @index < 9
      sum_shots + strike_bonus(frames)
    elsif spare? && @index < 9
      sum_shots + spare_bonus(frames)
    else
      sum_shots
    end
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    [@first_shot.score, @second_shot.score].sum == 10
  end

  def sum_shots
    [@first_shot.score, @second_shot.score, @third_shot.score].sum
  end

  def strike_bonus(frames)
    if next_frame(frames).strike? && @index < 8
      next_frame(frames).first_shot.score + next_next_frame(frames).first_shot.score
    else
      next_frame(frames).first_shot.score + next_frame(frames).second_shot.score
    end
  end

  def spare_bonus(frames)
    next_frame(frames).first_shot.score
  end

  private

  def next_frame(frames)
    frames[@index + 1]
  end

  def next_next_frame(frames)
    frames[@index + 2]
  end
end
