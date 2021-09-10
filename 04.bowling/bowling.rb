# frozen_string_literal: true

result = ARGV[0].split(',')
score = []
result.each do |r|
  if r == 'X'
    score << 10
    score << 0
  else
    score << r.to_i
  end
end

frames = score.each_slice(2).map { |s| s }

point = 0
frames.each_with_index do |frame, i|
  next_frame = frames[i + 1]
  after_next_frame = frames[i + 2]
  number_of_frame = i + 1

  # ストライクの時
  if frame[0] == 10
    point += 10
    next if number_of_frame > 9 # 9フレーム目以降は加算が無いので抜ける

    if next_frame.first == 10 && after_next_frame.first == 10 # 直後2投共にストライクの時
      point += 20
    elsif next_frame.first == 10 # 直後のみストライクの時
      point += 10
      point += after_next_frame.first
    else # それ以外
      point += next_frame.sum
    end
  # スペアの時
  elsif frame.sum == 10
    point += 10
    next if number_of_frame > 9 # 9フレーム目以降は加算が無いので抜ける

    point += next_frame.first # 直後1投の得点を加算
  # それ以外
  else
    point += frame.sum # そのフレームの合計を加算
  end
end

puts point
