# frozen_string_literal: true

require_relative 'shot'

class Game
  attr_reader :score_texts, :scores_numbers

  def initialize(score_texts)
    @score_texts = score_texts
  end

  def make_shot(score_texts)
    @scores_numbers = score_texts.split(',').map { |s| s == 'X' ? 10 : s.to_i }
    scores_numbers.each do |score_number|
      shot = Shot.new(score_number)
      p shot.score_number
    end
  end
end


