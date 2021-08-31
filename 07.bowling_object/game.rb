# frozen_string_literal: true
require_relative 'shot'
require_relative 'frame'

require './frame'

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

      point += if frame[0] == 10
                 frame.sum + left_shots.slice(0, 2).sum
               elsif frame.sum == 10
                 frame.sum + left_shots.fetch(0)
               else
                 frame.sum
               end
    end
    point
  end
end
