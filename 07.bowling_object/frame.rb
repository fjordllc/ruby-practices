require './shot'

class Frame
  def initialize(argv)
    @scores = Shot.new(argv)
  end

  def frames
    frames = []
    frame = []
    @scores.convert_num.each do |shot|
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
