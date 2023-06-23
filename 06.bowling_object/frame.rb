# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_score

  def initialize(first_mark, second_mark = nil)
    @first_score = Shot.new(first_mark).convert
    @second_score = Shot.new(second_mark).convert
  end

  def score
    @first_score + @second_score
  end

  def strike?
    first_score == 10
  end

  def calculate_point(next_frame, after_next_frame)
    point = score
    if strike?
      if next_frame.strike?
        point += first_score
        point += after_next_frame.first_score
      else
        point += next_frame.score
      end
    elsif score == 10
      point += next_frame.first_score
    end
    point
  end
end
