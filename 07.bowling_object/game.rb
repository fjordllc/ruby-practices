# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(argv)
    @game = []
    devide_frames(argv.split(','))
  end

  def devide_frames(marks)
    9.times do
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

  def calc_bonus(frame, left_shots)
    @score += if frame.strike?
      frame.score + left_shots.slice(0, 2).sum
    elsif frame.spare?
      frame.score + left_shots[0]
    else
      frame.score
    end
  end

  def score
    if @score.nil?
      @score = 0
      (0..9).each do |n|
        left_shots = []
        frame, next_frame, after_next_frame = @game.slice(n, 3)
        next_frame ||= Frame.new('', '')
        after_next_frame ||= Frame.new('', '')
        left_shots.push(*next_frame.shots).push(*after_next_frame.shots) # 次のフレームと次の次のフレームが一つの配列になる
        calc_bonus(frame, left_shots)
      end
      @score
    else
      @score
    end
  end
end
