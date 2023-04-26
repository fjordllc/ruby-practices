# frozen_string_literal: true

user_inputs = ARGV[0].split(',')

# 全て数字に変える
converted_nums = user_input.map { |score| score == 'X' ? 10 : score.to_i }

# フレームごとに区切る
current_throwing_location = 0

score = 0

10.times do
  score_of_two = converted_num[current_throwing_location] + converted_num[current_throwing_location + 1]
  # ストライク
  if converted_num[current_throwing_location] == 10
    score += score_of_two + converted_num[current_throwing_location + 2]
    current_throwing_location += 1
  # スペア
  elsif score_of_two == 10
    score += score_of_two + converted_num[current_throwing_location + 2]
    current_throwing_location += 2
  # 9本以下
  else
    score += score_of_two
    current_throwing_location += 2
  end
end

p score
