# frozen_string_literal: true

# score = ARGV
# score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
# score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
# score = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
# score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
# score = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
# score = 'X,X,X,X,X,X,X,X,X,X,X,X '
score_array = score.split(',')
score_array_num = []
score_array.each do |s|
  if s[0] == 'X'
    score_array_num.push(10)
    score_array_num.push(0)
  else
    score_array_num.push(s.to_i)
  end
end
frames = []
score_array_num.each_slice(2) do |s|
  frames.push(s)
end
total_score = 0
frames.each_with_index do |f, index|
  # ストライクの場合
  total_score = if index + 1 >= 10
                  total_score + f.sum
                elsif f[0] == 10 && frames[index + 1][0] == 10
                  total_score + frames[index + 1][0] + frames[index + 2][0] + 10
                elsif f[0] == 10 && frames[index + 1][0] != 10
                  total_score + frames[index + 1].sum + 10
                elsif f.sum == 10
                  total_score + frames[index + 1][0] + 10
                else
                  total_score + f.sum
                end
end
puts total_score
