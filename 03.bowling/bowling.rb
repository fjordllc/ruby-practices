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
10.times do |frame|
  point +=  if frames[frame][0] == 10 # strike
              if frames[frame + 1][0] == 10
                frames[frame].sum + frames[frame + 1].sum + frames[frame + 2][0]
              else
                frames[frame].sum + frames[frame + 1].sum
              end
            elsif frames[frame].sum == 10 # spare
              frames[frame].sum + frames[frame + 1][0]
            else
              frames[frame].sum
            end
end

p point
