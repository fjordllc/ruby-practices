# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :frames

  def initialize(scores)
    @scores = scores
  end

  def split_scores
    @scores.split(',')
  end

  def frame
    scores = []
    frames = []
    set_frames = []

    split_scores.each do |score|
      scores << score
      scores << '0' if scores.size < 18 && score == 'X'
    end

    scores.each_slice(2) { |score| frames << score }

    if frames.size > 10
      frames[9].concat(frames.last)
      frames.delete(frames.last)
    end

    frames.each do |shot|
      set_frames << Frame.new(shot[0], shot[1], shot[2])
    end
    set_frames
  end

  def score_calc
    @frames = frame
    total_score = []

    frames.each do |frame|
      current_frame = frames.index(frame)
      total_score << if frame.strike? && current_frame < 9
                       frame.score + next_frame_score(@frames, frame)
                     elsif frame.spare? && current_frame < 9
                       frame.score + next_frame_score(@frames, frame)
                     else
                       frame.score
                     end
    end
    puts total_score.sum
  end

  def next_frame_score(frames, frame)
    current_frame = frames.index(frame)
    next_frame_index = frames.index(frame) + 1
    if frame.strike?
      if frames[next_frame_index].strike? && current_frame < 8
        frames[next_frame_index].first_shot + frames[next_frame_index + 1].first_shot
      else
        frames[next_frame_index].first_shot + frames[next_frame_index].second_shot
      end
    else
      frames[next_frame_index].first_shot
    end
  end
end
