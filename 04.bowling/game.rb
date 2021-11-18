require_relative './frame'

class Game
  def initialize(pin)
    @game = pin
  end

  def frame_ary
    frame = []
    frames = []
    score_ary = @game.split(",")
    score_ary.each do |sa|
      frame.push(sa)
      if frames.length == 10
        frames.last.push(sa)
      elsif frame.size >= 2 || sa == 'X'
        frames.push(frame.dup)
        frame.clear
      end
    end
    frames
  end

  def frame_instance_ary
    frames = []
    frame_ary.each do |frame|
      frames.push(Frame.new(*frame))
    end
    frames
  end
end
