# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  def initialize(score_numbers)
    @frames = [] # 10frameを作る
    frame_marks = score_numbers.each_slice(2).to_a
    frame_marks.each_index do |i|
      @frames << Frame.new(frame_marks[i][0], frame_marks[i][1])
    end
    p @frames.size
  end

  def total_score
    total_frame_score = []
    @frames.each_with_index do |frame, i|
      total_frame_score << frame.calc_normal_frame
      # strikeだったら、calc_strike_frame
      # spareだったら、calc_spare_frame
      # 10フレーム以降は、calc_normal_frame
    end
    total_frame_score.sum
  end
end
