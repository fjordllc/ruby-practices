# frozen_string_literal: true

def calculate(table)
  scores = table.split(',')
  prepared_score = add_zero_shots(scores)

  # フレームごとに数字を分ける。ただし、10フレームは2つの要素に分かれることもある
  frames = prepared_score.each_slice(2).to_a
  p sum(frames)
end

# ストライクのフレームに0を加えて、投擲していないフレームに0を加える
def add_zero_shots(scores)
  shots = []
  scores.each do |s|
    case s
    when 'X'
      shots << 10
      shots << 0 if shots.length <= 18 # 最終フレームに0は加えない
    else
      shots << s.to_i
    end
  end
  shots
end

def sum(frames)
  result = 0
  frames.each_with_index do |frame, index|
    if index >= 9 # 10フレームはそのままスコアになる
      result += frame.inject(:+)
      next
    end

    # 1~9フレームでストライクとスペアのときの計算
    result += if frame[0] == 10 && frames[index + 1][0] == 10 # 二連続ストライクの時
                frame.inject(:+) + frames[index + 1][0] + frames[index + 2][0]
              elsif frame[0] == 10 # ストライクの時
                frame.inject(:+) + frames[index + 1].inject(:+)
              elsif frame.inject(:+) == 10 # スペアの時
                frame.inject(:+) + frames[index + 1][0]
              else
                frame.inject(:+) # そのほか
              end
  end
  result
end

calculate(ARGV[0]) if $PROGRAM_NAME == __FILE__
