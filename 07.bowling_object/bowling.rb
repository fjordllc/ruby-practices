#! /usr/bin/env ruby
# frozen_string_literal: true

class Game
  def initialize(result)
    @result = result
  end

  def show_score
    shots = create_shots(@result)
    frames = create_frames(shots)
    puts frames.map(&:score).inject(:+)
  end

  private

  def create_shots(result)
    result.chars.map { |mark| Shot.new(mark) }
  end

  def create_frames(shots)
    (1..10).each_with_object([]) do |count, frames|
      first_shot = shots.shift
      if count == 10
        second_shot = shots.shift
        third_shot = shots.shift
      elsif first_shot.score != 10
        second_shot = shots.shift
      end
      frames.push create_frame(first_shot, second_shot, third_shot, shots)
    end
  end

  def create_frame(first_shot, second_shot, third_shot, shots)
    frame = Frame.new(first_shot, second_shot, third_shot)
    return frame if shots.empty?

    if frame.strike?
      frame.bonus_score = shots[0].score + shots[1].score
    elsif frame.spare?
      frame.bonus_score = shots[0].score
    end
    frame
  end
end

class Frame
  attr_accessor :bonus_score

  def initialize(first_shot, second_shot, third_shot)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
    @bonus_score = 0
  end

  def score
    score = 0
    score += @first_shot.score
    score += @second_shot.score if @second_shot
    score += @third_shot.score if @third_shot
    score + @bonus_score
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    @first_shot.score + @second_shot.score == 10
  end
end

class Shot
  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if @mark == 'X'

    @mark.to_i
  end
end

Game.new(ARGV[0]).show_score
