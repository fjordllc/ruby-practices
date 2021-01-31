# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :pinfall_text

  def initialize(pinfall_text)
    @pinfall_text = pinfall_text
  end

  def pinfall_to_frames
    pinfalls = @pinfall_text.chars
    frames = []
    frame = []
    pinfalls.each do |pinfall|
      frame << pinfall
      if frames.size != 10
        if pinfall == 'X' || frame.size >= 2
          frames << frame.clone
          frame.clear
        end
      else
        frames.last << pinfall
      end
    end
    frames
  end

  def frames_to_class
    pinfall_to_frames.each.map { |frame| Frame.new(*frame) }
  end

  def points_per_frame
    frames = frames_to_class
    points = []
    frames.each.with_index(1) do |frame, index|
      points << if frame.strike? && !last_frame?(frames, index)
                  frame.score + add_strike_bonus(frames, index)
                elsif frame.spare? && !last_frame?(frames, index)
                  frame.score + add_spare_bonus(frames, index)
                else
                  frame.score
                end
    end
    points
  end

  def score
    points_per_frame.sum
  end

  private

  def last_frame?(frames, frame_number)
    frames.size == frame_number
  end

  def add_strike_bonus(frames, frame_number)
    next_frame = next_frame(frames, frame_number)
    next_next_frame = next_next_frame(frames, frame_number)
    if frame_before_last?(frame_number)
      next_frame.first_shot + next_frame.second_shot
    elsif next_frame.strike?
      next_frame.score + next_next_frame.first_shot
    else
      next_frame.score
    end
  end

  def add_spare_bonus(frames, frame_number)
    next_frame = next_frame(frames, frame_number)
    next_frame.first_shot
  end

  def frame_before_last?(frame_number)
    frame_number == 9
  end

  def next_frame(frames, frame_number)
    frames[frame_number]
  end

  def next_next_frame(frames, frame_number)
    frames[frame_number + 1]
  end
end
