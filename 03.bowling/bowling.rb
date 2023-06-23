#!/usr/bin/env ruby

# frozen_string_literal: true

STRIKE_SCORE = 10

to_integer_array = ARGV[0].split(',').map { |s| s == 'X' ? s : s.to_i }

divided_by_frame_array = []
tmp_array = []
to_integer_array.each_with_index do |num, i|
  if num == 'X'
    divided_by_frame_array << [num]
    tmp_array = []
  else
    tmp_array << num

    if tmp_array.size == 2 || i == to_integer_array.size - 1
      divided_by_frame_array << tmp_array
      tmp_array = []
    end
  end
end

excepted_x_score_array = divided_by_frame_array.map { |s| s == ['X'] ? [10] : s }

grouped_by_frame_scores_array = []
excepted_x_score_array.each_with_index do |array, i|
  if array.length == 2 && array.sum == STRIKE_SCORE && i != excepted_x_score_array.length - 1
    grouped_by_frame_scores_array << array.push(excepted_x_score_array[i + 1][0])
  elsif array[0] == STRIKE_SCORE
    if excepted_x_score_array[i + 1]&.size == 1
      if excepted_x_score_array[i + 1] && excepted_x_score_array[i + 2]
        grouped_by_frame_scores_array << array + [excepted_x_score_array[i + 1][0]] + [excepted_x_score_array[i + 2][0]]
      end
    else
      grouped_by_frame_scores_array << array + (excepted_x_score_array[i + 1]&.first(2) || [])
    end
  else
    grouped_by_frame_scores_array << array
  end
end

grouped_by_frame_scores_array.pop if grouped_by_frame_scores_array[-2].size == 3 && grouped_by_frame_scores_array[-1].size < 3

p grouped_by_frame_scores_array.flatten.sum
