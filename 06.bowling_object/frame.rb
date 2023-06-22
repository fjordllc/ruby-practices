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
end

def calculate_frame_point(frame, next_frame, after_next_frame)
  frame_point = 0
  frame_point += frame.score

  if frame.first_score == 10
    if next_frame.first_score == 10
      frame_point += frame.first_score
      frame_point += after_next_frame.first_score
    else
      frame_point += next_frame.score
    end
  elsif frame.score == 10
    frame_point += next_frame.first_score
  end
  frame_point
end
