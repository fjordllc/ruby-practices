# frozen_string_literal: true

class Game
  attr_reader :frame1, :frame2, :frame3, :frame4, :frame5, :frame6, :frame7, :frame8, :frame9, :frame10

  def initialize(marks)
    marks_grouped = Game.group_by_frame(marks.split(','))
    @frame1 = Frame.new(marks_grouped[0])
    @frame2 = Frame.new(marks_grouped[1])
    @frame3 = Frame.new(marks_grouped[2])
    @frame4 = Frame.new(marks_grouped[3])
    @frame5 = Frame.new(marks_grouped[4])
    @frame6 = Frame.new(marks_grouped[5])
    @frame7 = Frame.new(marks_grouped[6])
    @frame8 = Frame.new(marks_grouped[7])
    @frame9 = Frame.new(marks_grouped[8])
    @frame10 = Frame.new(marks_grouped[9])
  end

  def self.group_by_frame(marks)
    frames = Array.new(10) { [] }
    frames.each.with_index do |frame, i|
      if i == 9
        frame.concat(marks)
      elsif marks[0] == 'X'
        frame.push(marks.shift)
      else
        2.times { frame.push(marks.shift) }
      end
    end
    frames
  end

  def total_score
    sum_frames_score + sum_bonus_score
  end

  def sum_frames_score
    frames = [frame1, frame2, frame3, frame4, frame5, frame6, frame7, frame8, frame9, frame10]
    frames.map!(&:sum_shots_score).sum
  end

  def sum_bonus_score
    frames = [frame1, frame2, frame3, frame4, frame5, frame6, frame7, frame8, frame9, frame10]
    frames.map!.with_index do |frame, i|
      break if i == 9

      if frame.strike?
        strike_bonus_score(frames, i)
      elsif frame.spare?
        frames[i + 1].first_shot.score
      else
        0
      end
    end
    frames.pop
    frames.sum
  end

  def strike_bonus_score(frames, index)
    if index == 8 || !frames[index + 1].strike?
      frames[index + 1].first_shot.score + frames[index + 1].second_shot.score
    else
      10 + frames[index + 2].first_shot.score
    end
  end
end
