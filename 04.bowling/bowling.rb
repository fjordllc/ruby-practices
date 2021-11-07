#!/usr/bin/env ruby

# カレントフレームシステム
score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' #ストライク
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
frames.each do |frame|
  if frame[0] == 10 #strike
    point += 30
  elsif frame.sum == 10 #spare
    point += frame[0] + 10
  else
  point += frame.sum
  end
end

puts "カレントフレームシステムでの得点は#{point}点です。"


# mycode

# TODO
# 10フレーム目だけ3投目がある場合がある
score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' #ストライク
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
p frames.count
shots.each_slice(2) do |s|
  frames << s
  # if #10フレーム目だけ3投目がある場合がある
  # end
end
p frames

point = 0
strike = []
spare = []

# 通常の点数のみ加算するループ
# frames.each_with_index do |frame, i|
#   if frame[0] == 10 #strike
#     strike << i
#     point += frame.sum
#   elsif frame.sum == 10 #spare
#     spare << i
#     point += frame.sum
#   else
#     point += frame.sum
#   end
#     puts "現在の点数は#{point}点です。"
# end
# puts "スペア、ストライク加算なしの点数は#{point}点です。"

# p "ストライクになったフレーム数は#{strike}です"
# p "スペアになったフレーム数は#{spare}です"

# # ストライク、スペアの点数加算処理
# # スペア、ストライクは現在のフレームだけでは計算ができない
# spare_plus1 = 0
# # スペアをeachで回す スペアに+1して、それで次の投球分を指定して点数にプラスする
# spare.each do |s|
#   spare_plus1 = s + 1
#   puts "#{s}フレーム目にスペア! 次の一回の投球の点数が加算されます。"
#   point += frames[spare_plus1][0]
#   puts "現在#{point}点です。"
# end
# puts "通常の点数とスペアの分を加算した点数は #{point} 点です。"

# strike_plus1 = 0
# strike.each do |s|
#   strike_plus1 = s + 1
#   point += frames[strike_plus1][0]
#   puts "ストライクを出したので、次の投球である#{frames[strike_plus1][0]}点が加算されます。"
#   puts "現在#{point}点です。"

#   if frames[strike_plus1][1] == 0 #ストライクの次にストライクを出したケースの対応
#     point += frames[strike_plus1 + 1][0]
#     puts "ストライクを出したので、次の次の投球である#{frames[strike_plus1][0]}点が加算されます。"
#     puts "現在#{point}点です。"
#   else
#     point += frames[strike_plus1][1]
#     puts "ストライクを出したので、次の次の投球である#{frames[strike_plus1][1]}点が加算されます。"
#     puts "現在#{point}点です。"
#   end
# end

# puts "合計点数は #{point} 点です。"
