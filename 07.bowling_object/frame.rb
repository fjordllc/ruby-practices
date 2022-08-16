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
    # @first_shot.score + @second_shot.score
    @first_shot.mark + @second_shot.mark
  end

  # def calc_strike_frame
  #   puts 'ストライク' if @first_shot.score == 10
  # end
  #
  # def calc_spare_frame(frame)
  #   frame.frame_marks[frame.index][0] if @first_shot.score + @second_shot.score == 10 || @first_shot.score != 10
  # end
end
