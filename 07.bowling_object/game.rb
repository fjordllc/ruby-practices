# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  attr_reader :score_texts, :scores_numbers

  def initialize(score_texts)
    @score_texts = score_texts
  end

  def make_shot(score_texts)
    @scores_numbers = score_texts.split(',').map { |s| s == 'X' ? 10 : s.to_i }
    @scores_numbers.each do |score_number|
      shot = Shot.new(score_number)
      p shot.score_number
    end
  end

  def make_frames(score_texts)
    scores_numbers_for_frames = []
    score_texts.split(',').each do |score_text|
      if score_text == 'X'
        scores_numbers_for_frames << 10
        scores_numbers_for_frames << 0
      else
        scores_numbers_for_frames << score_text.to_i
      end
    end
    frames = []
    scores_numbers_for_frames.each_slice(2) do |score_number_for_frame|
      frames << score_number_for_frame
    end
    frames.each_with_index do |frame, _i|
      p Frame.new(frame)
    end
  end
end
