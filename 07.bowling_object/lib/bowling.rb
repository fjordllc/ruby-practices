#!/usr/bin/env ruby
# frozen_string_literal: true

class Game
  attr_reader :game_score, :shots, :frames, :all_score

  def initialize(game_mark)
    @game_score = game_mark.chars
    @shots = []
    @frames = []
    @all_score = []
  end

  def score
    frames = divide_frame
    10.times.each do |num|
      add_frames_score(frames, num)
    end
    all_score.sum
  end

  def add_frames_score(frames, num)
    all_score << if num <= 8
                   calc_frame_first_between_nineth(frames, num)
                 else
                   calc_frame_last(frames, num)
                 end
  end

  def calc_frame_last(frames, num)
    if current_frame_strike?(frames, num)
      if frames.size == 11
        Frame.new(frames[num][0], frames[num + 1][0], frames[num + 1][1]).score
      else
        Frame.new(frames[num][0], frames[num + 1][0], frames[num + 2][0]).score
      end
    elsif frames.size == 11
      Frame.new(frames[num][0], frames[num][1], frames[num + 1][0]).score
    else
      Frame.new(frames[num][0], frames[num][1], 0).score
    end
  end

  def calc_frame_first_between_nineth(frames, num)
    if current_frame_strike?(frames, num)
      if next_frame_strike?(frames, num)
        Frame.new(frames[num][0], frames[num + 1][0], frames[num + 2][0]).score
      else
        Frame.new(frames[num][0], frames[num + 1][0], frames[num + 1][1]).score
      end
    else
      Frame.new(frames[num][0], frames[num][1], frames[num + 1][0]).score
    end
  end

  def current_frame_strike?(frames, num)
    frames[num][0].include?('X')
  end

  def next_frame_strike?(frames, num)
    frames[num + 1][0].include?('X')
  end

  def divide_frame
    add_zero_when_strike.each_slice(2).map { |s| s }
  end

  def add_zero_when_strike
    game_score.each do |shot|
      if shot.include?('X')
        shots << 'X'
        shots << '0' if shots.size.odd?
      else
        shots << shot
      end
    end
    shots
  end
end

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    if strike?
      10 + [second_shot.score, third_shot.score].sum
    elsif spare?
      10 + third_shot.score
    else
      [first_shot.score, second_shot.score].sum
    end
  end

  def strike?
    first_shot.score == 10
  end

  def spare?
    [first_shot.score, second_shot.score].sum == 10
  end
end

class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if mark.include?('X')

    mark.to_i
  end
end

if __FILE__ == $PROGRAM_NAME # rubocop:disable Style/IfUnlessModifier
  puts Game.new(ARGV[0]).score
end
