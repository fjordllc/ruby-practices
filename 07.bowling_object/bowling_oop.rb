# !/usr/bin/env ruby
# frozen_string_literal: true

class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if mark == 'X'

    mark.to_i
  end
end

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_shot, second_shot)
    @first_shot = Shot.new(first_shot)
    @second_shot = Shot.new(second_shot)
  end
end

class Game
  def initialize(marks)
    @marks = marks
    splitted_marks = marks.split('')
    splitted_scores = insert_zero_after_strike_shot(splitted_marks)
    @frames = create_frames(splitted_scores)
  end

  MAX_INDEX_NUMBERS_FOR_9_FRAMES = 17

  def insert_zero_after_strike_shot(splitted_marks)
    splitted_scores = []
    index = 0
    splitted_marks.each do |each_mark|
      splitted_scores << Shot.new(each_mark).score
      if each_mark == 'X' && index.even? && index <= MAX_INDEX_NUMBERS_FOR_9_FRAMES
        splitted_scores << Shot.new('0').score
        index += 1
      end
      index += 1
    end
    splitted_scores
  end

  def create_frames(splitted_scores)
    frames = []
    splitted_scores.each_slice(2) do |s|
      frames << Frame.new(s[0], s[1])
    end
    frames
  end

  def calc_frames_score
    total_frames_score = 0
    @frames.each_with_index do |frame, index|
      return total_frames_score if index == 10

      current_frame = frame
      next_frame = @frames[index + 1]
      next_next_frame = @frames[index + 2]
      current_frame_score = calc_frame_score(current_frame, next_frame, next_next_frame, index)
      total_frames_score += current_frame_score
    end
    total_frames_score
  end

  def strike_bonus_point(_current_frame, next_frame, next_next_frame, _index)
    if next_frame.first_shot.mark == 10
      next_next_frame.nil? ? next_frame.second_shot.mark : next_next_frame.first_shot.mark
    else
      next_frame.second_shot.mark
    end
  end

  def calc_frame_score(current_frame, next_frame, next_next_frame, index)
    if index <= 8
      current_frame_score = if current_frame.first_shot.mark == 10
                              current_frame.first_shot.mark + next_frame.first_shot.mark + strike_bonus_point(current_frame, next_frame, next_next_frame, index)
                            elsif current_frame.first_shot.mark + current_frame.second_shot.mark == 10
                              current_frame.first_shot.mark + current_frame.second_shot.mark + next_frame.first_shot.mark
                            else
                              current_frame.first_shot.mark + current_frame.second_shot.mark
                            end
    else
      current_frame_score = current_frame.first_shot.mark + current_frame.second_shot.mark + (next_frame.nil? ? 0 : next_frame.first_shot.mark)
    end
    current_frame_score
  end
end
