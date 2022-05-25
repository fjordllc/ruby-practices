# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  shots << if s == 'X'
             10
           else
             s.to_i
           end
end

shot_index = 0
score_sum = 0
bonus_score_index = []
10.times do |n|
  if n <= 8
    if shots[shot_index] == 10
      bonus_score_index << shot_index + 1
      bonus_score_index << shot_index + 2
    else
      bonus_score_index << shot_index + 2 if shots[shot_index] +
                                             shots[shot_index + 1] == 10
      score_sum += shots[shot_index]
      shot_index += 1
    end
    score_sum += shots[shot_index]
    shot_index += 1
  else
    score_sum += shots[shot_index..].sum
  end
end

bonus_score_index.each do |index|
  score_sum += shots[index]
end

puts score_sum
