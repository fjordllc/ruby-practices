#!/usr/bin/env ruby

input_score = ARGV[0]
score_tokens = input_score.split(',')

# 各投球のピン数配列（rolls）
rolls = score_tokens.map do |token|
  case token
  when 'X'
    10
  else
    token.to_i
  end
end


total_score = 0
roll_index = 0  # 現在見ている投球位置

10.times do |frame_number|
  if rolls[roll_index] == 10
    # ストライク: 次の2投をボーナスとして加算
    total_score += 10 + rolls[roll_index + 1] + rolls[roll_index + 2]
    roll_index += 1
  else
    first_shot = rolls[roll_index]
    second_shot = rolls[roll_index + 1]
    frame_total = first_shot + second_shot

    if frame_total == 10
      # スペア: 次の1投をボーナスとして加算
      total_score += 10 + rolls[roll_index + 2]
    else
      total_score += frame_total
    end

    roll_index += 2
  end
end

puts total_score
