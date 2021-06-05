score = ARGV[0]
scores = score.split(",")
shots = []
scores.each do |s|
  if s == "X"
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a do |s| #配列内の要素を2つずつ渡す
  frames << s
end

point = frames.each_with_index.sum do |frame, i|
  if i > 8 || frame.sum < 10
    frame.sum
  elsif frame[0] == 10
    extra_point = frames[i.next]
    frame_point = frame.sum + extra_point.sum
    if extra_point[0] == 10
      double_extra_point = frames[i.next.next] # ダブルの場合は20点と次の次のフレームの1投目を加算する
      frame_point + double_extra_point[0]
    else
      frame_point
    end
  elsif frame.sum == 10
    extra_point = frames[i.next]
    frame.sum + extra_point[0]
  end
end

puts point
