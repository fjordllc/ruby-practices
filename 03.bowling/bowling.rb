# frozen_string_literal: true

inputs = ARGV[0].split(',')

# 全て数字に変える
to_i_inputs = inputs.map { |input| input == 'X' ? 10 : input.to_i }

# フレームごとに区切る
current_input_location = 0

score = 0

10.times do
  score_of_two = to_i_inputs[current_input_location] + to_i_inputs[current_input_location + 1]
  # ストライク
  if to_i_inputs[current_input_location] == 10
    score += score_of_two + to_i_inputs[current_input_location + 2]
    current_input_location += 1
  # スペア
  elsif score_of_two == 10
    score += score_of_two + to_i_inputs[current_input_location + 2]
    current_input_location += 2
  # 9本以下
  else
    score += score_of_two
    current_input_location += 2
  end
end

p score
