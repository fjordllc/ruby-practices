# frozen_string_literal: true

require './lib/frame'

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

