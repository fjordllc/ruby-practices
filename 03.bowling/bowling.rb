# frozen_string_literal: true

def score_strike(frames, idx)
  if frames[idx + 1][0] == 10
    frames[idx + 1][0] + frames[idx + 2][0] + 10
  else
    frames[idx + 1].sum + 10
  end
end

def score_spare(frames, idx)
  frames[idx + 1][0] + 10
end

def score_normal(frame)
  frame.sum
end

def shaping_to_frame(string)
  scores = string.split(',')
  shots = []
  scores.each do |s|
    if s == 'X' # strike
      shots << 10
      shots << 0
    else
      shots << s.to_i
    end
  end
  frames = []
  shots.each_slice(2) { |s| frames << s }
  frames
end

def bowling(score)
  frames = shaping_to_frame(score)
  point = 0
  frames.each_with_index do |frame, idx|
    break if idx == 9 # skip 10th frame

    point += if frame[0] == 10 # strike
               score_strike(frames, idx)
             elsif frame.sum == 10 # spare
               score_spare(frames, idx)
             else
               score_normal(frame)
             end
  end

  # calcu 10th frame
  frames[9..].each { |frame| point += frame.sum }
  puts point
end

if __FILE__ == $PROGRAM_NAME
  # 直接スクリプトファイルとして呼び出されたときだけ実行
  bowling(ARGV[0])
end
