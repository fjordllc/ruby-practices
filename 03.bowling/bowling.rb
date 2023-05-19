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
  s << 0 if s.size == 1
  frames << s
end

frames.each do |frame|
  if frame[0] == 10
   frame << {sum: 10, mark: :strike}
  elsif frame.sum == 10
    frame << {sum: 10, mark: :spare}
  else
    frame << {sum: frame.sum, mark: :none}
  end
end

(0..8).each do |number|
  current= frames[number]
  one_ahead=frames[number+1]
  two_ahead= frames[number+2]
  if current[2][:mark] == :strike
    if one_ahead[2][:mark] == :strike
      current[2][:sum] += 10 + two_ahead[0]
    else 
      current[2][:sum] += one_ahead[0]+one_ahead[1]
    end
  elsif current[2][:mark] == :spare
    current[2][:sum] += one_ahead[0]
  end
end

# if frames[10]
#   frames[9][2][:sum] +=[] 
# end

point = 0
frames.each do |frame|
  point += frame[2][:sum]
end

puts point

# point = 0
# frames.each do |frame|
#   if frame[0] == 10
#     point += 30
#   elsif frame.sum == 10
#     point += frame[0] + 10
#   else
#     point += frame.sum
#   end
# end

# puts point