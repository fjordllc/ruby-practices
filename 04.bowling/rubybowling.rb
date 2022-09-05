# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |item, i| # item=frame配列の値 i=要素の番号
  if item[0] == 10 && i < 9 # strike
    point = point + 10 + frames[i + 1][0] + frames[i + 1][1]
    point += frames[i + 2][0] if frames[i + 1][0] == 10 # strike2連続
  elsif item.sum == 10 && i < 9  # spare
    point = point + 10 + frames[i + 1][0]
  else
    point += item.sum
  end
end

puts point
