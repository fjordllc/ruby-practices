score = ARGV[0]
scores = score.split(',')

scores.each do |a|
    if a.to_i >= 11
        p "Read The Fucking Manual"
        exit
    end
end

shots = [ ]
scores.each do |s|
    if s == 'x' #xはストライク
        shots << 10
        shots << 0
    else
        shots << s.to_i
    end
end

frames = [ ]
shots.each_slice(2) do |s|
    frames << s
end

unless frames.count == 10
    p "フレーム数が不正だよお"
    exit
end

point = 0 
frames.each do |frame|
    if frame[0] == 10
        point = point + 30
    elsif frame.sum == 10
        point = frame[0] + 10
    else
        point = point + frame.sum
    end
end

p point
