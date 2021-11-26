# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(result)
    @result = result
  end

  def total_score
    score.sum
  end

  private

  def result_frame_per_array_storing
    frame = []
    frames = []
    @result.split(',').each do |result|
      frame.push(result)
      if frames.length == 10
        frames.last.push(result)
      elsif frame.size >= 2 || result == 'X'
        frames.push(frame.dup)
        frame.clear
      end
    end
    frames
  end

  def frames
    @frames ||= result_frame_per_array_storing.map do |frame|
      Frame.new(*frame)
    end
  end

  def score
    score = []
    frames.each_with_index do |frame, i|
      if last_frame?(i)
        score.push(frame.score)
      elsif frame.strike?
        score.push(frame.score + add_strike_points(i))
      elsif frame.spare?
        score.push(frame.score + add_spare_points(i))
      else
        score.push(frame.score)
      end
    end
    score
  end

  def add_strike_points(index)
    next_frame = next_frame(index)
    next_next_frame = frames[index + 2]
    if ninth_frame?(index)
      next_frame.first_shot.score + next_frame.second_shot.score
    elsif next_frame.strike?
      next_frame.score + next_next_frame.first_shot.score
    else
      next_frame.score
    end
  end

  def add_spare_points(index)
    next_frame(index).first_shot.score
  end

  def last_frame?(frame_index)
    last_frame_index = 9
    last_frame_index == frame_index
  end

  def ninth_frame?(frame_index)
    ninth_frame = 8
    ninth_frame == frame_index
  end

  def next_frame(index)
    frames[index + 1]
  end
end
