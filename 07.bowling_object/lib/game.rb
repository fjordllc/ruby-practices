# frozen_string_literal: true

class Game
  def initialize(score_text)
    @score_text = score_text
  end

  def to_frame
    scores = @score_text.split(',').map { |score| score == 'X' ? 10 : score.to_i }
    frames = []

    10.times do |i|
      frames << if i < 9
                  if scores[0] != 10
                    Frame.new(i + 1, scores.shift(2))
                  else
                    Frame.new(i + 1, [scores.shift])
                  end
                else
                  Frame.new(10, scores)
                end
    end
    frames
  end

  def total_pins(frames)
    frames.map(&:number_of_pins).sum
  end

  def find_frame(frames, frame_number)
    frames.find { |frame| frame.frame_number == frame_number }
  end
end
