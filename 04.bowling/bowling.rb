#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  elsif s == 'S'
    shots << 10
  else
    shots << s.to_i
  end
end
# p shots

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |frame, i|
  if frames[i][0] == 10
    # p frames[i]
    point += 10 + frames[i + 1].sum
  elsif frame.sum == 10
    # puts "#{frame}です。"
    #次の配列(frame)の一投目を加算
    point += 10 + frames[i + 1][0]
    # p frames[i + 1]
  else
    point += frames[i].sum
  end
end
puts point

# ストライクの次がまたストライク対応
# 加算用の配列
shots_for_add_x = []
scores.each do |s|
  if s == 'X'
    shots_for_add_x << 10
  elsif s == 'S'
    shots_for_add_x << 10
  else
    shots_for_add_x << s.to_i
  end
end
p shots_for_add_x

# 加算分の計算
add_x_point = 0
shots_for_add_x.each_with_index do |x, i| # xはshots_for_add_x配列の要素
  if shots_for_add_x[i] == 10 && shots_for_add_x[i + 1] == 10
    add_x_point += shots_for_add_x[i + 2]
  end
end
puts add_x_point

puts point + add_x_point
