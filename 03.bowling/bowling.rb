#!/usr/bin/env ruby
# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize
    @shots = []
  end

  def add_shot(pins)
    @shots << pins
  end

  def strike?
    shots.first == 10
  end

  def spare?
    shots.sum == 10 && !strike?
  end

  def score
    shots.sum
  end
end

class Game
  attr_reader :frames

  def initialize
    @frames = []
  end

  def add_shot(pins)
    frames << Frame.new if frames.empty? || new_frame_needed?
    frames.last.add_shot(pins)
  end

  def score
    total_score = 0
    frames.each_with_index do |frame, index|
      total_score += frame.score
      total_score += bonus_for_spare(index) if frame.spare?
      total_score += bonus_for_strike(index) if frame.strike?
    end
    total_score
  end

  private

  def new_frame_needed?
    return false if frames.count >= 10

    frames.last.strike? || frames.last.shots.count == 2
  end

  def bonus_for_spare(index)
    next_frame = frames[index + 1]
    next_frame ? next_frame.shots.first : 0
  end

  def bonus_for_strike(index)
    next_frame = frames[index + 1]
    return 0 unless next_frame

    next_two_shots = next_frame.shots[0, 2]
    next_two_shots << frames[index + 2].shots.first if next_frame.strike? && frames[index + 2]
    next_two_shots.sum
  end
end

shots = ARGV[0].split(',').map { |s| s == 'X' ? 10 : s.to_i }
game = Game.new
shots.each { |pins| game.add_shot(pins) }
puts game.score
