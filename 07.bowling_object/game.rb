# frozen_string_literal: true
require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(argv)
    @score = 0
    @game = []
    devide_frames(argv.split(','))
  end

  def devide_frames(marks)
    (0..8).each do
      first_mark = marks.shift
      if first_mark == 'X'
        @game << Frame.new(first_mark)
      else
        second_mark = marks.shift
        @game << Frame.new(first_mark, second_mark)
      end
    end
    @game << Frame.new(*marks)
  end

  def score
    (0..9).each do |now|
      left_shots = []
      frame, next_frame, after_next_frame = @game.slice(now, 3)
      next_frame ||= Frame.new("","")
      after_next_frame ||= Frame.new("","")
      left_shots.push(*next_frame.shots).push(*after_next_frame.shots) #次のフレームと次の次のフレームが一つの配列になる
      if frame.strike? && now != 9
        @score += frame.score + left_shots.slice(0, 2).sum
      elsif frame.spare? && now != 9
        @score += frame.score + left_shots[0]
      else
        @score += frame.score
      end
    end
    @score
  end
end
