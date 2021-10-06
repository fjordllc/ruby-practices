score = ARGV[0]
scores = score.split(',')

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
    if s.sum >= 11
        p 'Read The Fucking Manual'
        exit
    elsif s.count ==  2
    end
    
    frames << s
    binding.irb
end

unless frames.count == 10
    p "フレーム数が不正だよ"
    exit
end

point = 0 
frames.each do |frame|
    if frame[0] == 10 && frames[+1][0] == 10
        point = point + 10 + frames[+1].sum + frames[+2][0]
    elsif frame.sum == 10
        point = point + 10 + frames[+1][0]
    else
        point = point + frame.sum
    end
    binding.irb
end

p point
