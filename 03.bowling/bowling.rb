require 'rubocop'
require 'debug'

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
p frames
point = 0

frames.each_with_index do |frame, index|
    # binding.break
  if index >=9
    point += frame.sum
#   elsif frame_index == 11

  else
    if frame[0] == 10
        if frames[index + 1][0] == 10
            if frames[index + 2][0] == 10
                point += 30
            else
                point += 20 + frames[index + 2][0]
            end

        else
            point += 10 + frames[index + 1].sum
        end

      
    elsif frame.sum == 10
      point += 10 + frames[index + 1][0]
    else
      point += frame.sum
    end
  end
end

puts point
