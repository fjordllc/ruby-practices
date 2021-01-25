#!/usr/bin/env ruby
# frozen_string_literal: true

class Game
  attr_reader :game_score, :game_frames, :num

  def initialize(game_mark)
    @game_score = game_mark.chars
    @game_frames = []
    @num = 0
  end

  def score
    @game_frames = score_frames
    all_score = []
    10.times.each do |num|
      @num = num
      all_score << calc_frames_score
    end
    all_score.sum
  end

  def calc_frames_score
    if num == 9
      frame_is_last
    elsif game_frames[num].size == 1
      first_shot_is_strike
    else
      normal_score
    end
  end

  def frame_is_last
    if game_frames[num].size == 2
      Frame.new(game_frames[num][0], game_frames[num][1], '3').score
    else
      Frame.new(game_frames[num][0], game_frames[num][1], game_frames[num][2]).score
    end
  end

  def first_shot_is_strike
    if game_frames[num + 1].size == 1
      Frame.new(game_frames[num][0], game_frames[num + 1][0], game_frames[num + 2][0]).score
    else
      Frame.new(game_frames[num][0], game_frames[num + 1][0], game_frames[num + 1][1]).score
    end
  end

  def normal_score
    Frame.new(game_frames[num][0], game_frames[num][1], game_frames[num + 1][0]).score
  end


  def score_frames
    frames = []
    frame = []
    game_score.each do |shot|
      if frames[9]
        frames[9] << shot
      else
        frame << shot
        if frame[0] == 'X' || frame[1]
          frames << frame
          frame = []
        end
      end
    end
    frames
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
    [first_shot.score, second_shot.score].sum == 10 unless strike?
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
