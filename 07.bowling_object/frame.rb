# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def self.create_frames(input)
    base_mark_string = input.split(',')
    divided_marks = divide_marks(base_mark_string)
    divided_marks.map do |divided_mark|
      new(divided_mark[0], divided_mark[1], divided_mark[2])
    end
  end

  def self.divide_marks(base_mark_string)
    divided_marks = []
    first_string_index = 0
    while divided_marks.size < 10
      divided_mark = base_mark_string.slice(first_string_index, 3)
      if strike?(divided_mark)
        divided_marks << divided_mark
        first_string_index += 1
      elsif spare?(divided_mark)
        divided_marks << divided_mark
        first_string_index += 2
      else
        divided_mark[2] = '0'
        divided_marks << divided_mark
        first_string_index += 2
      end
    end
    divided_marks
  end

  def self.strike?(divided_mark)
    divided_mark[0] == 'X'
  end

  def self.spare?(divided_mark)
    divided_mark[0].to_i + divided_mark[1].to_i == 10
  end

  def score
    first_shot.score + second_shot.score + third_shot.score
  end
end
