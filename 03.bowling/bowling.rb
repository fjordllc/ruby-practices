# frozen_string_literal: true

scoreboard = ARGV[0].split(',').to_a.collect { |score| score.casecmp('X').zero? ? 10 : score.to_i }

total_score = 0
current_position = 0

1.upto(10) do
  if scoreboard[current_position] == 10
    total_score += 10 + scoreboard[current_position + 1] + scoreboard[current_position + 2]
    current_position += 1
  else
    frame_score = scoreboard[current_position].to_i + scoreboard[current_position + 1].to_i
    total_score += frame_score < 10 ? frame_score : frame_score + scoreboard[current_position + 2]
    current_position += 2
  end
end

puts total_score
