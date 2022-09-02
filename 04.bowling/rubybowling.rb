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
frames.each_with_index do |frame,count|
  if frame[0] == 10 && count < 9             #strike
    point = point + 10 + frames[count + 1].sum
    if frames[count + 1][0] == 10
      point = point + frames[count + 2][0]
    end
  elsif frame[0] + frame[1] == 10 && count < 9  #spare
    point = point + 10 + frames[count + 1][0]
  else
    point = point + frame.sum
  end
end

puts point