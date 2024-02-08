#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize
    @frames = []
  end

  def add_shot(pins)
    @frames << Frame.new if @frames.empty? || new_frame_needed?
    @frames.last.add_shot(pins)
  end

  def score
    @frames.each_with_index.sum do |frame, index|
      frame_score = frame.score
      frame_score += bonus_for_spare(index) if frame.spare?
      frame_score += bonus_for_strike(index) if frame.strike?
      frame_score
    end
  end

  private

  def new_frame_needed?
    return false if @frames.count >= 10

    @frames.last.strike? || @frames.last.shots.count == 2
  end

  def bonus_for_spare(index)
    next_frame = @frames[index + 1]
    next_frame ? next_frame.shots.first : 0
  end

  def bonus_for_strike(index)
    next_frame = @frames[index + 1]
    return 0 unless next_frame

    next_two_shots = next_frame.shots[0, 2]
    next_two_shots << @frames[index + 2].shots.first if next_frame.strike? && @frames[index + 2]
    next_two_shots.sum
  end
end
