# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_accessor :first_shot, :second_shot, :frame_marks, :index

  def initialize(first_shot, second_shot, frame_marks, index)
    @first_shot = Shot.new(first_shot)
    @second_shot = Shot.new(second_shot)
    @frame_marks = frame_marks
    @index = index
  end

  def calc_normal_frame
    @second_shot.mark = 0 if @second_shot.mark.nil?
    @first_shot.mark + @second_shot.mark
  end

  def spare?
    @first_shot.mark != 10 && @first_shot.mark + @second_shot.mark == 10
    # @frame_marks[index + 1][0]
  end

  def calc_spare
    after_frame = @index
    @frame_marks[after_frame + 1][0]
  end

  def strike?
    @first_shot.mark == 10
  end

  def calc_strike
    after_frame = @index
    @frame_marks[after_frame + 1][0] + @frame_marks[after_frame + 1][1]
  end

  def consecutive_strike?
    after_frame = @index
    @first_shot.mark == 10 && @frame_marks[after_frame + 1][0] == 10
  end

  def calc_consecutive_strike
    after_frame = @index
    @frame_marks[after_frame + 1][0] + @frame_marks[after_frame + 2][0]
  end
end

# frame1 = Frame.new(6, 3,  [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10, 0], [9, 1], [8, 0], [10, 0], [6, 4], [5]], 1)
# p frame1
# p frame1.index
# after_frame = frame1.index
# p after_frame
# p frame1.frame_marks[0]
# p frame1.frame_marks[1]
# p frame1.frame_marks[after_frame]

