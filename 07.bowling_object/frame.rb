# frozen_string_literal: true

require_relative 'game'
require_relative 'shot'

class Frame
  attr_accessor :frame, :first_shot, :second_shot

  def initialize(frame)
    @frame = frame
    @first_shot = frame[0]
    @second_shot = frame[1]
  end

  def frame_score(frame)
    frame.sum
  end
end

# frame = [1,2]
# frame1 = Frame.new(frame)
# p frame1.frame_score(frame)

