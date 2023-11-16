require 'debug'

class Game
  attr_reader :frame1, :frame2, :frame3, :frame4, :frame5, :frame6, :frame7, :frame8, :frame9, :frame10

  def initialize(frames)
    @frame1 = Frame.new(frames[0])
    @frame2 = Frame.new(frames[1])
    @frame3 = Frame.new(frames[2])
    @frame4 = Frame.new(frames[3])
    @frame5 = Frame.new(frames[4])
    @frame6 = Frame.new(frames[5])
    @frame7 = Frame.new(frames[6])
    @frame8 = Frame.new(frames[7])
    @frame9 = Frame.new(frames[8])
    @frame10 = Frame.new(frames[9])
  end

  def total_score
    sum_frames_score + sum_bonus_score
  end

  def sum_frames_score
    frame1.sum_shots_score + frame2.sum_shots_score + frame3.sum_shots_score + frame4.sum_shots_score + frame5.sum_shots_score + frame6.sum_shots_score + frame7.sum_shots_score + frame8.sum_shots_score + frame9.sum_shots_score + frame10.sum_shots_score
  end

  def sum_bonus_score
    frames = [frame1, frame2, frame3, frame4, frame5, frame6, frame7, frame8, frame9, frame10]
    frames.map!.with_index do |frame, i|
      break if i == 9
      if frame.strike?
        if i == 8 || !frames[i + 1].strike?
          frames[i + 1].first_shot.score + frames[i + 1].second_shot.score
        else
          10 + frames[i + 2].first_shot.score
        end
      elsif frame.spare?
        frames[i + 1].first_shot.score
      else
        0
      end
    end
    frames.delete_at(-1)
    frames.sum
  end
end
