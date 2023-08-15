# frozen_string_literal: true

scores = ARGV[0].split(',').to_a

total_score = 0
current_position = 0

def check_if_x(score)
  score == 'X' ? 10 : score.to_i
end

1.upto(10) do
  if scores[current_position] == 'X'
    total_score += 10 + check_if_x(scores[current_position + 1]) + check_if_x(scores[current_position + 2])
    current_position += 1
  else
    frame_score = scores[current_position].to_i + scores[current_position + 1].to_i
    total_score += frame_score < 10 ? frame_score : frame_score + check_if_x(scores[current_position + 2])
    current_position += 2
  end
end

puts total_score
