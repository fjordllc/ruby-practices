# frozen_string_literal: true

class Divide
  attr_reader :input
  def initialize(input)
    @input = input
  end

  # 分離してフレームごとに分ける
  def divide_by_frame
    frames = []
    marks = input
    (1..10).each do |i|
      if i == 10
        frames << marks
      elsif marks[0] == 'X'
        frames << [marks[0]]
        marks.slice!(0, 1)
      else
        frames << [marks[0], marks[1]]
        marks.slice!(0, 2)
      end
    end
    frames
  end
end