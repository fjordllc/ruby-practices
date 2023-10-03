#! /usr/bin/env ruby

# １投ごとに分割する
score = ARGV[0]
scores = score.split(',')

# スコアを数値に変換
shots = []
scores.each do |s|
    if s == 'X'
        shots << 10
        shots << 0
    else
        shots << s.to_i
    end
end

# フレームごとに分割
frames = []
shots.each_slice(2) do |s|
    frames << s
end

# ポイントを加算
point = 0
for i in 0...10 do
    # 10フレーム目
    if (i == 9)
        point += frames[i].sum
        if (frames[i + 1] != nil)
            point += frames[i + 1].sum
        end
        if (frames[i + 2] != nil)
            point += frames[i + 2].sum
        end
    else
        if (frames[i][0] == 10) # strike
            point += 10 + frames[i + 1].sum
            # 次のフレームもstrikeだった場合、更に次のフレームの１投目も加算
            if (frames[i + 1][0] == 10)
                point += frames[i + 2][0]
            end
        elsif (frames[i].sum == 10) # spare
            point += 10 + frames[i + 1][0]
        else
            point += frames[i].sum
        end
    end
end

puts point
