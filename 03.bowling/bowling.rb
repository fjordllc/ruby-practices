# frozen_string_literal: true

require 'optparse'
require 'debug'

user_input = ARGV[0].split(',')

# 全て数字に変える
user_input_convert_num = user_input.map { |score| score == 'X' ? 10 : score.to_i }

# フレームごとに区切る
split_user_input = 0

score = 0

10.times do |frame|
  score_of_two = user_input_convert_num[split_user_input] + user_input_convert_num[split_user_input + 1]
  # ストライク
  if user_input_convert_num[split_user_input] == 10
    sum_of_frame = score_of_two + user_input_convert_num[split_user_input + 2]
    sum_of_frame += user_input_convert_num[split_user_input + 3] if frame == 10
    score += sum_of_frame
    split_user_input += 1
  # スペア
  elsif score_of_two == 10
    sum_of_frame = score_of_two + user_input_convert_num[split_user_input + 2]
    sum_of_frame += user_input_convert_num[split_user_input + 3] if frame == 10
    score += sum_of_frame
    split_user_input += 2
  # 9本以下
  else
    sum_of_frame = score_of_two
    score += sum_of_frame
    split_user_input += 2
  end
end

p score
