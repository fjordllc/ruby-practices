# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(argument)
    scores = argument.to_s.split(',')
    shots = []
    scores.each do |s|
      if s == 'X'
        shots << 10
        shots << 0
      else
        shots << s.to_i
      end
    end

    frames = shots.each_slice(2).to_a
    @frames = frames.map { |frame| Frame.new(frame[0], frame[1]) }
  end

  def game_score
    point = 0
    @frames.each.with_index do |frame, index|
      break if index == 10

      point += frame.frame_score
      if frame.first_score == 10
        if @frames[index + 1].first_score == 10
          point += frame.first_score
          point += @frames[index + 2].first_score
        else
          point += @frames[index + 1].frame_score
        end
      elsif frame.frame_score == 10
        point += @frames[index + 1].first_score
      end
    end
    point
  end
end
