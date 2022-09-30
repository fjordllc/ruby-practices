# frozen_string_literal: true

class Game
  def initialize(score_text)
    @score_text = score_text
  end

  def to_frame
    scores = @score_text.split(',').map { |score| score == 'X' ? 10 : score.to_i }
    frames = []

    10.times do |i|
      frames << if i < 9
                  if scores[0] != 10
                    Frame.new(i + 1, scores.shift(2))
                  else
                    Frame.new(i + 1, [scores.shift])
                  end
                else
                  Frame.new(10, scores)
                end
    end
    frames
  end

  def total_pins(frames)
    frames.map(&:number_of_pins).sum
  end

  def bonus_score(frames)
    bonus_scores = []
    bonus_frames = frames[0..8].select(&:bonus_score?)

    bonus_frames.each do |frame|
      target_frame = find_frame(frames, frame.frame_number + 1)

      if frame.strike? && target_frame.strike? && target_frame.frame_number < 10
        # ストライク → ストライク → 次のフレームの場合
        # 第9フレームがストライク → 第10フレームの1投目がストライク の場合はこの分岐に入れたくないので
        # target_frame.frame_number < 10 の条件を入れています
        after_target_frame = find_frame(frames, target_frame.frame_number + 1)
        bonus_scores << target_frame.first_shot.pins + after_target_frame.first_shot.pins
      elsif frame.strike?
        # ストライク → 次のフレームで2投投げる場合
        bonus_scores << target_frame.first_shot.pins + target_frame.second_shot.pins
      else
        # スペアの場合
        bonus_scores << target_frame.first_shot.pins
      end
    end
    bonus_scores.sum
  end

  def find_frame(frames, frame_number)
    frames.find { |frame| frame.frame_number == frame_number }
  end
end
