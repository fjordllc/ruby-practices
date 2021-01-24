#!/usr/bin/env ruby
# frozen_string_literal: true

class Game
  attr_reader :game_score, :shots, :frames, :num

  def initialize(game_mark)
    @game_score = game_mark.chars
    @shots = []
    @frames = []
    @num = 0
  end

  def score
    @frames = divide_frame
    all_score = []
    10.times.each do |num|
      @num = num
      all_score << calc_frames_score
    end
    all_score.sum
  end

  def calc_frames_score
    num <= 8 ? calc_frame_first_between_nineth : calc_frame_last
  end

  def calc_frame_last
    if current_frame_strike?
      calc_frame_last_when_strike
    elsif frames.size == 11
      calc_frame_combi_basic
    else
      Frame.new(frames[num][0], frames[num][1], 0).score
    end
  end

  def calc_frame_last_when_strike
    if frames.size == 11
      calc_frame_combi_frames_current_index_zero_and_next_frames
    else
      calc_frame_combi_frames_index_zero
    end
  end

  def calc_frame_first_between_nineth
    if current_frame_strike?
      calc_frame_first_between_nineth_when_strike
    else
      calc_frame_combi_basic
    end
  end

  def calc_frame_first_between_nineth_when_strike
    if next_frame_strike?
      calc_frame_combi_frames_index_zero
    else
      calc_frame_combi_frames_current_index_zero_and_next_frames
    end
  end

  def calc_frame_combi_frames_current_index_zero_and_next_frames
    Frame.new(frames[num][0], frames[num + 1][0], frames[num + 1][1]).score
  end

  def calc_frame_combi_frames_index_zero
    Frame.new(frames[num][0], frames[num + 1][0], frames[num + 2][0]).score
  end

  def calc_frame_combi_basic
    Frame.new(frames[num][0], frames[num][1], frames[num + 1][0]).score
  end

  def current_frame_strike?
    frames[num][0].include?('X')
  end

  def next_frame_strike?
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
    mark.include?('X') ? 10 : mark.to_i
  end
end

if __FILE__ == $PROGRAM_NAME # rubocop:disable Style/IfUnlessModifier
  puts Game.new(ARGV[0]).score
end
