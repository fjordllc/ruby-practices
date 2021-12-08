# frozen_string_literal: true

def strike?(frame)
  frame[0] == 10
end

def calculate(frames)
  result = 0
  frames.each_with_index do |frame, index|
    # 9投目以下かつストライクまたはスペアの場合
    if index < 9 && frame.sum == 10
      # ストライクの場合
      result += if strike?(frame)
                  # 連続でストライクのとき
                  if frames[index + 1][0] == 10
                    frames[index + 1][0] + frames[index + 2][0]
                  else
                    frames[index + 1][0] + frames[index + 1][1]
                  end
                else
                  # スペアの処理
                  frames[index + 1][0]
                end
    end
    result += frame.sum
  end
  result
end

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

result = calculate(frames)
puts result
