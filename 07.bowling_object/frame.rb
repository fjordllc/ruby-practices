require './shot'

class Frame
  def initialize(marks)
    @shots = Shot.new(marks).parse_marks
  end

  def divide_into_frames
    frames = []
    frame = []
    @shots.each do |shot|
      frame << shot
      if frames.size < 10
        if frame.size >= 2 || shot == 10
          frames << frame.dup
          frame.clear
        end
      else
        frames.last << shot
      end
    end
    frames
  end
end
