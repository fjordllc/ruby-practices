# frozen_string_literal: true

score = ARGV[0]
score_array = score.to_s.split(',')
score_array_num = []
score_array.each do |s|
  if s[0] == 'X'
    score_array_num.push(10)
    score_array_num.push(0)
  else
    score_array_num.push(s.to_i)
  end
end
p score_array_num
frames = []
score_array_num.each_slice(2) do |s|
  frames.push(s)
end
total_score = 0
frames.each_with_index do |f, index|
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
