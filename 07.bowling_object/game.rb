# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  def initialize(score_numbers)
    @frames = [] # 10frameを作る
    frame_marks = score_numbers.each_slice(2).to_a
    frame_marks.each_index do |index|
      @frames << Frame.new(frame_marks[index][0], frame_marks[index][1], frame_marks, index)
    end
    pp @frames
  end

  def sum_up
    sum_up = []
    sum_up << calc_total_score
    sum_up << calc_point
    sum_up.flatten.sum
  end

  def calc_total_score
    total_frame_score = []
    @frames.each do |frame|
      total_frame_score << frame.calc_normal_frame
    end
    total_frame_score.sum
  end

  def calc_point
    total_point = []
    @frames.each_with_index do |frame, index|
      break if index == 9

      if frame.first_shot.mark == 10 && frame.frame_marks[index + 1][0] == 10
        total_point << frame.frame_marks[index + 1][0]
        total_point << frame.frame_marks[index + 2][0]
      elsif frame.first_shot.mark == 10
        total_point << frame.frame_marks[index + 1][0]
        total_point << frame.frame_marks[index + 1][1]
      elsif frame.first_shot.mark != 10 && frame.calc_normal_frame == 10
        total_point << frame.frame_marks[index + 1][0]
      else
        total_point << 0
      end
    end
    total_point
  end
end
