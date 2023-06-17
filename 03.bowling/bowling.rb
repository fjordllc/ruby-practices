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
  shots.each_slice(2).to_a
end

def bowling(score)
  frames = shaping_to_frame(score)
  point = 0
  frames.each_with_index do |frame, idx|
    point += frame.sum
    next if idx >= 9 || frame.sum != 10

    # これ以降は9フレーム以内、かつ、スペアかストライクのどちらか
    point += if frame[0] == 10
               # ストライクのボーナススコア
               if frames[idx + 1][0] == 10
                 frames[idx + 1][0] + frames[idx + 2][0]
               else
                 frames[idx + 1].sum
               end
             else
               # スペアのボーナススコア
               frames[idx + 1][0]
             end
  end
  puts point
end

if __FILE__ == $PROGRAM_NAME
  # 直接スクリプトファイルとして呼び出されたときだけ実行
  bowling(ARGV[0])
end
