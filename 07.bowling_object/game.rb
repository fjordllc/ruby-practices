# frozen_string_literal: true

class Game
  attr_reader :frames
  def initialize(frames)
    @frames = frames
  end

  def total_score
    # 分割されたものを使ってスコア計算する
    base_score + extra_score
  end

  private

  def base_score
    base_score = 0
    frames.each do |frame|
      base_score += Frame.new(frame[0], frame[1], frame[2]).score
    end
    base_score
  end

  def extra_score
    extra_score = 0
    frames.each.with_index(1) do |frame, index|
      # ストライクの場合
      if frame[0] == 10
        extra_score += strike_extra_score(frames, index)
      # スペアの場合
      elsif frame.sum == 10
        extra_score += spare_extra_score(frames, index)
      end
    end
    extra_score
  end

  def strike_extra_score
    return 0
  end

  def strike_extra_score
    return 1
  end
end