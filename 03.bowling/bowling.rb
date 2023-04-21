# frozen_string_literal: true

require 'optparse'
require 'debug'

user_input = ARGV[0].split(',')

# 全て数字に変える
converted_num = user_input.map { |score| score == 'X' ? 10 : score.to_i }

# フレームごとに区切る
split_user_input = 0

score = 0

10.times do |frame|
  score_of_two = converted_num[split_user_input] + converted_num[split_user_input + 1]
  # ストライク
  if converted_num[split_user_input] == 10
    score += score_of_two + converted_num[split_user_input + 2]
    split_user_input += 1
  # スペア
  elsif score_of_two == 10
    score += score_of_two + converted_num[split_user_input + 2]
    split_user_input += 2
  # 9本以下
  else
    score += score_of_two
    split_user_input += 2
  end
  p frame
end

p score
