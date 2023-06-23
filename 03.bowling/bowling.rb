#!/usr/bin/env ruby

STRIKE_SCORE = 10

to_integer_array = ARGV[0].split(',').map { |s| s == 'X' ? s : s.to_i }

dividedByFrameArray = []
tmp_array = []
to_integer_array.each_with_index do |num, i|
  if num == 'X'
    dividedByFrameArray << [num]
    tmp_array = []
  else
    tmp_array << num

    if tmp_array.size == 2 || i == to_integer_array.size - 1
      dividedByFrameArray << tmp_array
      tmp_array = []
    end
  end
end

excepted_X_score_array = dividedByFrameArray.map { |s| s == ['X'] ? [10] : s }

groupedByFrameScoresArray = []
excepted_X_score_array.each_with_index do |array, i|
  if array.length == 2 && array.sum == STRIKE_SCORE && i != excepted_X_score_array.length - 1
    groupedByFrameScoresArray << array.push(excepted_X_score_array[i + 1][0])
  elsif array[0] == STRIKE_SCORE
    if excepted_X_score_array[i + 1]&.size == 1
      if excepted_X_score_array[i + 1] && excepted_X_score_array[i + 2]
        groupedByFrameScoresArray << array + [excepted_X_score_array[i + 1][0]] + [excepted_X_score_array[i + 2][0]]
      end
    else
      groupedByFrameScoresArray << array + (excepted_X_score_array[i + 1]&.first(2) || [])
    end
  else
    groupedByFrameScoresArray << array
  end
end

if groupedByFrameScoresArray[-2].size == 3 && groupedByFrameScoresArray[-1].size < 3
  groupedByFrameScoresArray.pop
end

p groupedByFrameScoresArray.flatten.sum