# frozen_string_literal: true

scoreboard = ARGV[0].split(',').to_a

total_score = 0
current_position = 0

def convert_ten_if_score_is_x(current_score)
  current_score == 'X' ? 10 : current_score.to_i
end

1.upto(10) do
  if scoreboard[current_position] == 'X'
    total_score += 10 + convert_ten_if_score_is_x(scoreboard[current_position + 1]) + convert_ten_if_score_is_x(scoreboard[current_position + 2])
    current_position += 1
  else
    frame_score = scoreboard[current_position].to_i + scoreboard[current_position + 1].to_i
    total_score += frame_score < 10 ? frame_score : frame_score + convert_ten_if_score_is_x(scoreboard[current_position + 2])
    current_position += 2
  end
end

puts total_score
