score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a
 
point = 0
frames.each_index do |index|
  if index == 9
    point += frames[index..].sum { |frame| frame.sum }
    break
  end
  if frames[index][0] == 10 && frames[index + 1][0] == 10 # strike * 2
    point += frames[index + 2][0] + 20
  elsif frames[index][0] == 10 # strike * 1
    point += frames[index + 1].sum + 10
  elsif frames[index].sum == 10 # spare
    point += frames[index + 1][0] + 10
  else
    point += frames[index].sum
  end
end

puts point

