#!/usr/bin/env ruby

# frozen_string_literal: true

STRIKE_SCORE = 10
TOTAL_GAME_COUNT = 10

parsed_score_numbers = ARGV[0].split(',').map { |s| s == 'X' ? 10 : s.to_i }

divided_by_frame_score_pairs = []
tmp_scores = []
parsed_score_numbers.each do |num|
  if tmp_scores == [] && num == STRIKE_SCORE && divided_by_frame_score_pairs.size < TOTAL_GAME_COUNT - 1
    divided_by_frame_score_pairs << [num]
    tmp_scores = []
  else
    tmp_scores << num
    if tmp_scores.size == 2
      divided_by_frame_score_pairs << tmp_scores
      tmp_scores = [] unless divided_by_frame_score_pairs.size == TOTAL_GAME_COUNT
    end
  end
end

frame_result_point_pairs = []
divided_by_frame_score_pairs.each_with_index do |each_frame_scores, i|
  if each_frame_scores.length == 1
    frame_result_point_pairs << if divided_by_frame_score_pairs[i + 1] && divided_by_frame_score_pairs[i + 2] && divided_by_frame_score_pairs[i + 1].size == 1
                                  each_frame_scores + [divided_by_frame_score_pairs[i + 1][0]] + [divided_by_frame_score_pairs[i + 2][0]]
                                else
                                  each_frame_scores + divided_by_frame_score_pairs[i + 1]&.first(2)
                                end
  elsif each_frame_scores.length == 2
    frame_result_point_pairs << if each_frame_scores.sum == STRIKE_SCORE
                                  each_frame_scores.push(divided_by_frame_score_pairs[i + 1][0])
                                else
                                  each_frame_scores
                                end
  else
    frame_result_point_pairs << each_frame_scores
  end
end

p frame_result_point_pairs.flatten.sum
