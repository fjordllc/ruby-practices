# frozen_string_literal: true

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
               if frames[idx + 1][0] == 10 # strike , twice in a row
                 frames[idx + 1][0] + frames[idx + 2][0] + 10
               else
                 frames[idx + 1].sum + 10
               end
             elsif frame.sum == 10 # spare
               frames[idx + 1][0] + 10
             else
               frame.sum
             end
  end

  # calcu 10th frame
  frames[9..].each { |frame| point += frame.sum }
  point
end

if __FILE__ == $PROGRAM_NAME
  # 直接スクリプトファイルとして呼び出されたときだけ実行
  bowling(ARGV[0])
end
