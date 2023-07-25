#!/usr/bin/env ruby

# frozen_string_literal: true

STRIKE_SCORE = 10
TOTAL_GAME_COUNT = 10

parsed_score_numbers = ARGV[0].split(',').map { |s| s == 'X' ? 10 : s.to_i }

frames_score_points = []
tmp_scores = []
parsed_score_numbers.each do |num|
  if tmp_scores.empty? && num == STRIKE_SCORE && frames_score_points.size < TOTAL_GAME_COUNT - 1
    frames_score_points << [num]
    tmp_scores = []
  else
    tmp_scores << num
    if tmp_scores.size == 2
      frames_score_points << tmp_scores
      tmp_scores = [] unless frames_score_points.size == TOTAL_GAME_COUNT
    end
  end
end

frame_result_points = []
frames_score_points.each_with_index do |frame_scores, i|
  if frame_scores.length == 1
    frame_result_points << if frames_score_points[i + 1] && frames_score_points[i + 2] && frames_score_points[i + 1].size == 1
                                  frame_scores + [frames_score_points[i + 1][0]] + [frames_score_points[i + 2][0]]
                                else
                                  frame_scores + frames_score_points[i + 1]&.first(2)
                                end
  elsif frame_scores.length == 2
    frame_result_points << if frame_scores.sum == STRIKE_SCORE
                                  frame_scores << frames_score_points[i + 1][0]
                                else
                                  frame_scores
                                end
  else
    frame_result_points << frame_scores
  end
end

puts frame_result_points.flatten.sum
