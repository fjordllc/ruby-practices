# frozen_string_literal: true

class Frame
  MAX_FRAME_COUNT = 10

  def initialize(base_scores)
    @base_scores = base_scores
  end

  def create_frames
    frames = []

    while frames.count < (MAX_FRAME_COUNT - 1)
      # 9フレーム目までの処理
      frames << @base_scores.slice(frames.count * 2, 2)
    end
    # 10フレーム目までの処理
    frames << @base_scores.slice(frames.count * 2..-1)
  end
end
