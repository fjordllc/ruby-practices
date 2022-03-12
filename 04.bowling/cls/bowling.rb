# frozen_string_literal: true

class Bowling
  def initialize(arg)
    @shots = []
    @frames = []
    init_shots(arg)
    @third_shot = @shots.pop if @shots.size == 21
    init_frames
    print_score
  end

  private

  # 引数で受け取ったスコアを配列にする処理
  def init_shots(arg)
    scores = arg.split(',')
    scores.each do |s|
      # 10フレーム目のstrike
      if (@shots.size >= 18) && (s == 'X')
        @shots << 10
      elsif s == 'X' # strike
        @shots << 10
        @shots << 0 # init_framesで削除される
      else
        @shots << s.to_i
      end
    end
  end

  # スコアをフレームごとに配列にする処理
  def init_frames
    @shots.each_slice(2) do |s|
      # init_shots時の余計な0を削除
      s.pop if (s[0] == 10) && (@frames.size <= 8)
      @frames << s
    end
    # 最終フレームに3投目を追加
    @frames.last.push(@third_shot) if @frames.last.sum >= 10
  end

  def print_score
    point = 0
    @frames.each_with_index do |frame, idx|
      # strike, spare計算用の次フレームの取得
      next_frame = @frames[idx + 1] unless idx == 9
      point += calc_point(frame, next_frame, idx)
    end
    puts point
  end

  # スコア計算処理
  def calc_point(frame, next_frame, idx)
    if frame.size == 3 # 10フレーム目で3投した場合
      frame.sum
    elsif (frame.size == 1) && (next_frame.size == 1) # 連続strike
      10 + next_frame.sum + @frames[idx + 2][0]
    elsif frame.size == 1 # strike
      10 + next_frame[0] + next_frame[1]
    elsif frame.sum == 10 # spare
      10 + next_frame[0]
    else
      frame.sum
    end
  end
end
